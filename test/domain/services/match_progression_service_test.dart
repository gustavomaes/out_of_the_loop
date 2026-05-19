import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/domain/services/match_progression_service.dart';
import 'package:outoftheloop/src/domain/services/vote_scoring_service.dart';

void main() {
  group('MatchProgressionService', () {
    const service = MatchProgressionService();

    test('completes two rounds and carries players and used words forward', () {
      final setup = MatchSetup(
        categoryId: 'food',
        roundCount: 2,
        players: _players(3),
        language: SupportedLanguage.ptBr,
      );
      final initialMatch = service.startMatch(setup);
      final roundOne = _round(
        roundNumber: 1,
        wordId: 'pizza',
        outPlayerId: 'p2',
      );
      final roundTwo = _round(
        roundNumber: 2,
        wordId: 'sushi',
        outPlayerId: 'p1',
      );

      final afterRoundOneStart = service.startRound(
        match: initialMatch,
        round: roundOne,
      );
      final afterRoundOneComplete = service.completeCurrentRound(
        match: afterRoundOneStart,
        result: _result(
          outPlayerId: 'p2',
          scoreEvents: const [
            ScoreEvent(
              playerId: 'p0',
              points: 100,
              reason: ScoreReasons.majorityFoundOut,
            ),
          ],
        ),
      );
      final afterRoundTwoStart = service.startRound(
        match: afterRoundOneComplete,
        round: roundTwo,
      );
      final afterRoundTwoComplete = service.completeCurrentRound(
        match: afterRoundTwoStart,
        result: _result(
          outPlayerId: 'p1',
          scoreEvents: const [
            ScoreEvent(
              playerId: 'p1',
              points: 175,
              reason: ScoreReasons.outPlayerGuessedWord,
            ),
          ],
        ),
      );

      expect(afterRoundTwoComplete.players, setup.players);
      expect(afterRoundTwoComplete.usedWordIds, {'pizza', 'sushi'});
      expect(afterRoundTwoComplete.totalScores['p0'], 100);
      expect(afterRoundTwoComplete.totalScores['p1'], 175);
      expect(
        service.isFinalRoundComplete(
          match: afterRoundTwoComplete,
          roundCount: setup.roundCount,
        ),
        isTrue,
      );
    });

    test('produces final ranking by total score', () {
      final match = MatchState(
        players: _players(3),
        rounds: const [],
        currentRoundIndex: -1,
        usedWordIds: const {},
        totalScores: const {'p0': 25, 'p1': 150, 'p2': 50},
      );

      final ranking = service.ranking(match);

      expect(ranking.map((player) => player.id), ['p1', 'p2', 'p0']);
      expect(ranking.first.totalScore, 150);
    });
  });
}

List<Player> _players(int count) => List.generate(
  count,
  (index) =>
      Player(id: 'p$index', name: 'Player $index', avatarSeed: 'seed-$index'),
);

RoundState _round({
  required int roundNumber,
  required String wordId,
  required String outPlayerId,
}) {
  final secretWord = SecretWord(
    id: wordId,
    categoryId: 'food',
    value: _localized(wordId),
    questions: [
      Question(id: '$wordId-q1', wordId: wordId, text: _localized('Q1')),
      Question(id: '$wordId-q2', wordId: wordId, text: _localized('Q2')),
      Question(id: '$wordId-q3', wordId: wordId, text: _localized('Q3')),
    ],
  );
  return RoundState(
    roundNumber: roundNumber,
    outPlayerId: outPlayerId,
    secretWord: secretWord,
    questions: secretWord.questions,
    phase: RoundPhase.reveal,
  );
}

RoundResult _result({
  required String outPlayerId,
  required List<ScoreEvent> scoreEvents,
}) {
  return RoundResult(
    outPlayerId: outPlayerId,
    voteCounts: const {},
    wasOutFoundByMajority: true,
    guessWasCorrect: null,
    scoreEvents: scoreEvents,
  );
}

LocalizedText _localized(String value) => LocalizedText({
  SupportedLanguage.ptBr: value,
  SupportedLanguage.en: value,
  SupportedLanguage.es: value,
  SupportedLanguage.hi: value,
});
