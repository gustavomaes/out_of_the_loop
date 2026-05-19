import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/domain/services/vote_scoring_service.dart';

void main() {
  group('VoteScoringService', () {
    const service = VoteScoringService();

    test('records each player vote only once', () {
      final votes = service.recordVote(
        existingVotes: const [],
        vote: const Vote(voterId: 'p1', suspectId: 'p2'),
      );

      expect(votes, hasLength(1));
      expect(
        () => service.recordVote(
          existingVotes: votes,
          vote: const Vote(voterId: 'p1', suspectId: 'p3'),
        ),
        throwsStateError,
      );
    });

    test('calculates majority as more than half', () {
      expect(
        service.hasMajority(
          playerId: 'p4',
          playerCount: 5,
          voteCounts: const {'p4': 2},
        ),
        isFalse,
      );
      expect(
        service.hasMajority(
          playerId: 'p4',
          playerCount: 5,
          voteCounts: const {'p4': 3},
        ),
        isTrue,
      );
    });

    test('scores correct votes and majority discovery', () {
      final players = _players(5);
      final round = _round(
        outPlayerId: 'p4',
        votes: const [
          Vote(voterId: 'p0', suspectId: 'p4'),
          Vote(voterId: 'p1', suspectId: 'p4'),
          Vote(voterId: 'p2', suspectId: 'p4'),
          Vote(voterId: 'p3', suspectId: 'p0'),
          Vote(voterId: 'p4', suspectId: 'p0'),
        ],
      );

      final result = service.calculateRoundResult(
        round: round,
        players: players,
      );

      expect(result.wasOutFoundByMajority, isTrue);
      expect(result.guessWasCorrect, isNull);
      expect(
        result.scoreEvents.where(
          (event) =>
              event.reason == ScoreReasons.correctVote && event.points == 25,
        ),
        hasLength(3),
      );
      expect(
        result.scoreEvents.where(
          (event) =>
              event.reason == ScoreReasons.majorityFoundOut &&
              event.points == 100,
        ),
        hasLength(4),
      );
    });

    test('scores no-majority tie and correct out-player guess', () {
      final round = _round(
        outPlayerId: 'p3',
        votes: const [
          Vote(voterId: 'p0', suspectId: 'p3'),
          Vote(voterId: 'p1', suspectId: 'p2'),
          Vote(voterId: 'p2', suspectId: 'p1'),
          Vote(voterId: 'p3', suspectId: 'p0'),
        ],
      );

      final result = service.calculateRoundResult(
        round: round,
        players: _players(4),
        guessWasCorrect: true,
      );

      expect(result.wasOutFoundByMajority, isFalse);
      expect(result.voteCounts, {'p3': 1, 'p2': 1, 'p1': 1, 'p0': 1});
      expect(
        result.scoreEvents,
        containsAll(const [
          ScoreEvent(
            playerId: 'p0',
            points: 25,
            reason: ScoreReasons.correctVote,
          ),
          ScoreEvent(
            playerId: 'p3',
            points: 50,
            reason: ScoreReasons.outPlayerEscaped,
          ),
          ScoreEvent(
            playerId: 'p3',
            points: 125,
            reason: ScoreReasons.outPlayerGuessedWord,
          ),
        ]),
      );
    });

    test('does not award guess points for wrong guess', () {
      final result = service.calculateRoundResult(
        round: _round(
          outPlayerId: 'p2',
          votes: const [
            Vote(voterId: 'p0', suspectId: 'p1'),
            Vote(voterId: 'p1', suspectId: 'p0'),
            Vote(voterId: 'p2', suspectId: 'p0'),
          ],
        ),
        players: _players(3),
        guessWasCorrect: false,
      );

      expect(
        result.scoreEvents.any(
          (event) => event.reason == ScoreReasons.outPlayerGuessedWord,
        ),
        isFalse,
      );
    });
  });
}

List<Player> _players(int count) => List.generate(
  count,
  (index) =>
      Player(id: 'p$index', name: 'Player $index', avatarSeed: 'seed-$index'),
);

RoundState _round({required String outPlayerId, required List<Vote> votes}) {
  return RoundState(
    roundNumber: 1,
    outPlayerId: outPlayerId,
    secretWord: SecretWord(
      id: 'pizza',
      categoryId: 'food',
      value: _localized('Pizza'),
      questions: [
        Question(id: 'q1', wordId: 'pizza', text: _localized('Question')),
      ],
    ),
    questions: [
      Question(id: 'q1', wordId: 'pizza', text: _localized('Question')),
    ],
    phase: RoundPhase.results,
    votes: votes,
  );
}

LocalizedText _localized(String value) => LocalizedText({
  SupportedLanguage.ptBr: value,
  SupportedLanguage.en: value,
  SupportedLanguage.es: value,
  SupportedLanguage.hi: value,
});
