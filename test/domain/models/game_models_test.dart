import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';

void main() {
  const localizedPizza = LocalizedText({
    SupportedLanguage.ptBr: 'Pizza',
    SupportedLanguage.en: 'Pizza',
    SupportedLanguage.es: 'Pizza',
    SupportedLanguage.hi: 'पिज़्ज़ा',
  });

  const question = Question(
    id: 'pizza-q1',
    wordId: 'pizza',
    text: LocalizedText({
      SupportedLanguage.ptBr: 'Quando voce comeria isto?',
      SupportedLanguage.en: 'When would you eat this?',
      SupportedLanguage.es: 'Cuando comerias esto?',
      SupportedLanguage.hi: 'आप इसे कब खाएंगे?',
    }),
  );

  group('content models', () {
    test('support localized values and value equality', () {
      expect(localizedPizza.valueFor(SupportedLanguage.ptBr), 'Pizza');
      expect(
        const LocalizedText({SupportedLanguage.en: 'Pizza'}),
        const LocalizedText({SupportedLanguage.en: 'Pizza'}),
      );
    });

    test('construct category, secret word, and questions', () {
      const category = Category(
        id: 'food',
        name: LocalizedText({SupportedLanguage.en: 'Food'}),
        iconKey: 'restaurant',
      );
      final word = SecretWord(
        id: 'pizza',
        categoryId: category.id,
        value: localizedPizza,
        questions: const [question],
      );

      expect(category.iconKey, 'restaurant');
      expect(word.categoryId, 'food');
      expect(word.questions, const [question]);
      expect(
        word,
        SecretWord(
          id: 'pizza',
          categoryId: 'food',
          value: localizedPizza,
          questions: const [question],
        ),
      );
    });
  });

  group('gameplay models', () {
    final players = List.generate(
      3,
      (index) => Player(
        id: 'p$index',
        name: 'Player $index',
        avatarSeed: 'seed-$index',
      ),
    );

    test('represent minimum and maximum player boundaries', () {
      expect(MatchSetup.isSupportedPlayerCount(2), isFalse);
      expect(MatchSetup.isSupportedPlayerCount(3), isTrue);
      expect(MatchSetup.isSupportedPlayerCount(9), isTrue);
      expect(MatchSetup.isSupportedPlayerCount(10), isFalse);

      final minimumSetup = MatchSetup(
        categoryId: 'food',
        roundCount: 5,
        questionsPerPlayer: 2,
        players: players,
        language: SupportedLanguage.ptBr,
      );
      final maximumSetup = MatchSetup(
        categoryId: 'food',
        roundCount: 5,
        questionsPerPlayer: 1,
        players: List.generate(
          9,
          (index) => Player(
            id: 'max-$index',
            name: 'Player $index',
            avatarSeed: 'seed-$index',
          ),
        ),
        language: SupportedLanguage.en,
      );

      expect(minimumSetup.hasSupportedPlayerCount, isTrue);
      expect(maximumSetup.hasSupportedPlayerCount, isTrue);
    });

    test('construct round and match state with value equality', () {
      final secretWord = SecretWord(
        id: 'pizza',
        categoryId: 'food',
        value: localizedPizza,
        questions: const [question],
      );
      final vote = const Vote(voterId: 'p1', suspectId: 'p2');
      final scoreEvent = const ScoreEvent(
        playerId: 'p1',
        points: 25,
        reason: 'correctVote',
      );
      final round = RoundState(
        roundNumber: 1,
        outPlayerId: 'p2',
        secretWord: secretWord,
        questions: const [question],
        phase: RoundPhase.voting,
        votes: [vote],
        scoreEvents: [scoreEvent],
      );
      final match = MatchState(
        players: players,
        rounds: [round],
        currentRoundIndex: 0,
        usedWordIds: {'pizza'},
        totalScores: {'p1': 25, 'p2': 0, 'p3': 0},
      );

      expect(match.currentRound, round);
      expect(
        match,
        MatchState(
          players: players,
          rounds: [round],
          currentRoundIndex: 0,
          usedWordIds: {'pizza'},
          totalScores: {'p1': 25, 'p2': 0, 'p3': 0},
        ),
      );
    });

    test('construct round result and timer settings', () {
      final result = RoundResult(
        outPlayerId: 'p2',
        voteCounts: {'p2': 2, 'p1': 1},
        wasOutFoundByMajority: true,
        guessWasCorrect: null,
        scoreEvents: const [
          ScoreEvent(playerId: 'p1', points: 100, reason: 'majorityFoundOut'),
        ],
      );

      expect(result.wasOutFoundByMajority, isTrue);
      expect(result.guessWasCorrect, isNull);
      expect(const TimerSettings(), const TimerSettings());
      expect(const TimerSettings().durationSeconds, 30);
    });
  });
}
