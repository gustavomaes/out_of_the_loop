import '../models/models.dart';

final class MatchProgressionService {
  const MatchProgressionService();

  MatchState startMatch(MatchSetup setup) {
    return MatchState(
      players: setup.players,
      rounds: const [],
      currentRoundIndex: -1,
      usedWordIds: const {},
      totalScores: {
        for (final player in setup.players) player.id: player.totalScore,
      },
    );
  }

  MatchState startRound({
    required MatchState match,
    required RoundState round,
  }) {
    return MatchState(
      players: match.players,
      rounds: [...match.rounds, round],
      currentRoundIndex: match.rounds.length,
      usedWordIds: {...match.usedWordIds, round.secretWord.id},
      totalScores: match.totalScores,
    );
  }

  MatchState completeCurrentRound({
    required MatchState match,
    required RoundResult result,
  }) {
    final currentRound = match.currentRound;
    if (currentRound == null) {
      throw StateError('Cannot complete a match without an active round.');
    }

    final completedRound = RoundState(
      roundNumber: currentRound.roundNumber,
      outPlayerId: currentRound.outPlayerId,
      secretWord: currentRound.secretWord,
      questions: currentRound.questions,
      questionTurns: currentRound.questionTurns,
      phase: RoundPhase.complete,
      votes: currentRound.votes,
      scoreEvents: result.scoreEvents,
    );
    final rounds = match.rounds.toList();
    rounds[match.currentRoundIndex] = completedRound;

    return MatchState(
      players: match.players,
      rounds: rounds,
      currentRoundIndex: match.currentRoundIndex,
      usedWordIds: match.usedWordIds,
      totalScores: _applyScoreEvents(match.totalScores, result.scoreEvents),
    );
  }

  bool isFinalRoundComplete({
    required MatchState match,
    required int roundCount,
  }) {
    return match.rounds
            .where((round) => round.phase == RoundPhase.complete)
            .length >=
        roundCount;
  }

  List<Player> ranking(MatchState match) {
    final players = match.players
        .map(
          (player) => Player(
            id: player.id,
            name: player.name,
            avatarSeed: player.avatarSeed,
            totalScore: match.totalScores[player.id] ?? player.totalScore,
          ),
        )
        .toList();
    players.sort((left, right) {
      final scoreCompare = right.totalScore.compareTo(left.totalScore);
      if (scoreCompare != 0) {
        return scoreCompare;
      }
      return left.name.compareTo(right.name);
    });
    return List.unmodifiable(players);
  }

  Map<String, int> _applyScoreEvents(
    Map<String, int> currentScores,
    List<ScoreEvent> scoreEvents,
  ) {
    final nextScores = Map<String, int>.of(currentScores);
    for (final event in scoreEvents) {
      nextScores[event.playerId] =
          (nextScores[event.playerId] ?? 0) + event.points;
    }
    return Map.unmodifiable(nextScores);
  }
}
