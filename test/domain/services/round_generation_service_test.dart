import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/domain/services/round_generation_service.dart';

void main() {
  group('RoundGenerationService', () {
    test('marks exactly one player as out per round', () {
      final service = RoundGenerationService(random: Random(1));
      final players = _players(4);

      final round = service.generateRound(
        roundNumber: 1,
        players: players,
        questionsPerPlayer: 1,
        categoryWords: [_word('pizza', questionCount: 4)],
        usedWordIds: const {},
      );

      expect(
        players.where((player) => player.id == round.outPlayerId),
        hasLength(1),
      );
      expect(round.phase, RoundPhase.reveal);
    });

    test('does not repeat used words in the same match', () {
      final service = RoundGenerationService(random: Random(1));

      final round = service.generateRound(
        roundNumber: 2,
        players: _players(3),
        questionsPerPlayer: 1,
        categoryWords: [
          _word('used', questionCount: 3),
          _word('fresh', questionCount: 3),
        ],
        usedWordIds: {'used'},
      );

      expect(round.secretWord.id, 'fresh');
    });

    test('skips words with too few questions for the player count', () {
      final service = RoundGenerationService(random: Random(1));

      final round = service.generateRound(
        roundNumber: 1,
        players: _players(5),
        questionsPerPlayer: 1,
        categoryWords: [
          _word('too-short', questionCount: 4),
          _word('playable', questionCount: 5),
        ],
        usedWordIds: const {},
      );

      expect(round.secretWord.id, 'playable');
      expect(round.questions, hasLength(5));
    });

    test('includes multiple questions per player when configured', () {
      final service = RoundGenerationService(random: Random(1));

      final round = service.generateRound(
        roundNumber: 1,
        players: _players(3),
        questionsPerPlayer: 2,
        categoryWords: [_word('pizza', questionCount: 6)],
        usedWordIds: const {},
      );

      expect(round.questions, hasLength(6));
      expect(round.questionTurns, hasLength(6));
      expect(round.questionTurns.first.playerId, isNot(round.outPlayerId));
    });

    test('throws when no playable words remain', () {
      final service = RoundGenerationService(random: Random(1));

      expect(
        () => service.generateRound(
          roundNumber: 1,
          players: _players(4),
          questionsPerPlayer: 1,
          categoryWords: [_word('used', questionCount: 4)],
          usedWordIds: {'used'},
        ),
        throwsStateError,
      );
    });
  });
}

List<Player> _players(int count) => List.generate(
  count,
  (index) =>
      Player(id: 'p$index', name: 'Player $index', avatarSeed: 'seed-$index'),
);

SecretWord _word(String id, {required int questionCount}) {
  return SecretWord(
    id: id,
    categoryId: 'food',
    value: _localized(id),
    questions: List.generate(
      questionCount,
      (index) => Question(
        id: '$id-q$index',
        wordId: id,
        text: _localized('Question $index'),
      ),
    ),
  );
}

LocalizedText _localized(String value) => LocalizedText({
  SupportedLanguage.ptBr: value,
  SupportedLanguage.en: value,
  SupportedLanguage.es: value,
  SupportedLanguage.hi: value,
  SupportedLanguage.ar: value,
});
