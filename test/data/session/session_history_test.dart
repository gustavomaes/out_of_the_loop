import 'dart:convert';
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:outoftheloop/src/data/session/session_repository.dart';
import 'package:outoftheloop/src/app/game_flow_controller.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/domain/models/play_history.dart';
import 'package:outoftheloop/src/domain/services/round_generation_service.dart';
import 'package:outoftheloop/src/domain/services/match_setup_service.dart';

const players = [
  Player(id: 'a', name: 'Alex', avatarSeed: 'a'),
  Player(id: 'b', name: 'Sam', avatarSeed: 'b'),
  Player(id: 'c', name: 'Jamie', avatarSeed: 'c'),
];
SecretWord word(String id, {int count = 9, String category = 'food'}) =>
    SecretWord(
      id: id,
      categoryId: category,
      value: LocalizedText({SupportedLanguage.en: id}),
      questions: List.generate(
        count,
        (i) => Question(
          id: '$id-$i',
          wordId: id,
          text: LocalizedText({SupportedLanguage.en: 'Question $i'}),
        ),
      ),
    );
RoundState generate(
  List<SecretWord> words,
  PlayHistory history, {
  Set<String> used = const {},
  SupportedLanguage language = SupportedLanguage.en,
  GameMode mode = GameMode.guided,
}) => RoundGenerationService(random: Random(1)).generateRound(
  roundNumber: 1,
  players: players,
  questionsPerPlayer: 1,
  categoryWords: words,
  usedWordIds: used,
  history: history,
  language: language,
  mode: mode,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));
  test('unseen words win, then oldest words return without blocking play', () {
    final history = PlayHistory();
    final words = [word('one'), word('two'), word('three')];
    final seen = <String>[];
    for (var i = 0; i < 3; i++) {
      final round = generate(words, history);
      seen.add(round.secretWord.id);
      history.record(round, SupportedLanguage.en);
    }
    expect(seen.toSet(), hasLength(3));
    expect(generate(words, history).secretWord.id, seen.first);
    expect(generate(words, history, used: {seen.first}).secretWord.id, seen[1]);
  });
  test('word history is isolated by language and category', () {
    final history = PlayHistory(words: ['en:food:one', 'en:food:two']);
    expect(generate([word('one'), word('two')], history).secretWord.id, 'one');
    history.words.add('es:food:one');
    expect(
      generate(
        [word('one'), word('two')],
        history,
        language: SupportedLanguage.es,
      ).secretWord.id,
      'two',
    );
    final other = generate([word('one', category: 'travel')], history);
    expect(other.secretWord.categoryId, 'travel');
  });
  test('questions rotate before returning to oldest prompts', () {
    final history = PlayHistory();
    final words = [word('one')];
    final selected = <String>[];
    for (var i = 0; i < 3; i++) {
      final round = generate(words, history);
      selected.addAll(round.questions.map((q) => q.id));
      history.record(round, SupportedLanguage.en);
    }
    expect(selected.toSet(), hasLength(9));
    expect(
      generate(words, history).questions.map((q) => q.id).toList(),
      selected.take(3).toList(),
    );
  });
  test(
    'free mode can use words without questions and never fabricates question turns',
    () {
      final words = [word('one', count: 0), word('two', count: 0)];
      final result = const MatchSetupService().validate(
        players: players,
        roundCount: 2,
        questionsPerPlayer: 1,
        categoryWords: words,
        mode: GameMode.free,
      );
      expect(result.canStart, isTrue);
      final round = generate(words, PlayHistory(), mode: GameMode.free);
      expect(round.questions, isEmpty);
      expect(round.questionTurns, isEmpty);
      expect(() => generate(words, PlayHistory()), throwsStateError);
    },
  );
  test(
    'restart restores history, group, mode and configuration with zero scores',
    () async {
      final repository = SessionRepository();
      final history = PlayHistory();
      history.record(generate([word('one')], history), SupportedLanguage.en);
      await repository.save(
        SavedSession(
          history: history,
          players: players,
          mode: GameMode.free,
          roundCount: 4,
          questionsPerPlayer: 2,
        ),
      );
      final flow = GameFlowController(sessionRepository: SessionRepository());
      await flow.loadSession();
      expect(flow.savedPlayers.map((p) => p.name), ['Alex', 'Sam', 'Jamie']);
      expect(flow.savedPlayers.every((p) => p.totalScore == 0), isTrue);
      expect(flow.mode, GameMode.free);
      expect(flow.savedRoundCount, 4);
      expect(flow.history.words, ['en:food:one']);
      flow.resetHistory();
      await flow.flushSession();
      expect((await repository.load()).history.words, isEmpty);
      expect((await repository.load()).players, hasLength(3));
      flow.forgetSavedGroup();
      await flow.flushSession();
      expect((await repository.load()).players, isEmpty);
    },
  );
  test('corrupted session is ignored and names are de-duplicated', () async {
    SharedPreferences.setMockInitialValues({
      SessionRepository.storageKey: '{broken',
    });
    expect((await SessionRepository().load()).players, isEmpty);
    SharedPreferences.setMockInitialValues({
      SessionRepository.storageKey: jsonEncode({
        'version': 1,
        'players': ['Alex', ' alex ', '', 'Sam'],
        'roundCount': 900,
      }),
    });
    final saved = await SessionRepository().load();
    expect(saved.players.map((p) => p.name), ['Alex', 'Sam']);
    expect(saved.roundCount, 5);
  });
}
