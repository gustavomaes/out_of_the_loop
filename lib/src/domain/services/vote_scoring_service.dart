import '../models/models.dart';

final class ScoreReasons {
  const ScoreReasons._();

  static const correctVote = 'correctVote';
  static const majorityFoundOut = 'majorityFoundOut';
  static const outPlayerEscaped = 'outPlayerEscaped';
  static const outPlayerGuessedWord = 'outPlayerGuessedWord';
}

final class VoteScoringService {
  const VoteScoringService();

  List<Vote> recordVote({
    required List<Vote> existingVotes,
    required Vote vote,
  }) {
    if (existingVotes.any((existing) => existing.voterId == vote.voterId)) {
      throw StateError('Player "${vote.voterId}" has already voted.');
    }
    return List.unmodifiable([...existingVotes, vote]);
  }

  Map<String, int> countVotes(List<Vote> votes) {
    final counts = <String, int>{};
    for (final vote in votes) {
      counts[vote.suspectId] = (counts[vote.suspectId] ?? 0) + 1;
    }
    return Map.unmodifiable(counts);
  }

  bool hasMajority({
    required String playerId,
    required int playerCount,
    required Map<String, int> voteCounts,
  }) {
    return (voteCounts[playerId] ?? 0) > playerCount / 2;
  }

  RoundResult calculateRoundResult({
    required RoundState round,
    required List<Player> players,
    bool? guessWasCorrect,
  }) {
    final voteCounts = countVotes(round.votes);
    final wasOutFoundByMajority = hasMajority(
      playerId: round.outPlayerId,
      playerCount: players.length,
      voteCounts: voteCounts,
    );
    final scoreEvents = <ScoreEvent>[];

    for (final vote in round.votes) {
      if (vote.suspectId == round.outPlayerId &&
          vote.voterId != round.outPlayerId) {
        scoreEvents.add(
          ScoreEvent(
            playerId: vote.voterId,
            points: 25,
            reason: ScoreReasons.correctVote,
          ),
        );
      }
    }

    if (wasOutFoundByMajority) {
      for (final player in players) {
        if (player.id != round.outPlayerId) {
          scoreEvents.add(
            ScoreEvent(
              playerId: player.id,
              points: 100,
              reason: ScoreReasons.majorityFoundOut,
            ),
          );
        }
      }
    } else {
      scoreEvents.add(
        ScoreEvent(
          playerId: round.outPlayerId,
          points: 50,
          reason: ScoreReasons.outPlayerEscaped,
        ),
      );
      if (guessWasCorrect == true) {
        scoreEvents.add(
          ScoreEvent(
            playerId: round.outPlayerId,
            points: 125,
            reason: ScoreReasons.outPlayerGuessedWord,
          ),
        );
      }
    }

    return RoundResult(
      outPlayerId: round.outPlayerId,
      voteCounts: voteCounts,
      wasOutFoundByMajority: wasOutFoundByMajority,
      guessWasCorrect: wasOutFoundByMajority ? null : guessWasCorrect,
      scoreEvents: scoreEvents,
    );
  }
}
