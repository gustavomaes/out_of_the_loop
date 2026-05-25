import 'dart:math';

import '../models/models.dart';

final class QuestionTurnPlanner {
  QuestionTurnPlanner({Random? random}) : _random = random ?? Random();

  final Random _random;

  List<QuestionTurn> planTurns({
    required List<Player> players,
    required List<Question> questions,
    required String outPlayerId,
    required int questionsPerPlayer,
  }) {
    if (questions.isEmpty || questionsPerPlayer < 1) {
      return const [];
    }

    final expectedCount = players.length * questionsPerPlayer;
    if (questions.length != expectedCount) {
      throw StateError(
        'Expected $expectedCount questions for ${players.length} players '
        'at $questionsPerPlayer questions each, got ${questions.length}.',
      );
    }

    final assignments = <String>[];
    for (final player in players) {
      assignments.addAll(List.filled(questionsPerPlayer, player.id));
    }

    _shuffleNonOutFirst(assignments, outPlayerId);

    return List.generate(
      questions.length,
      (index) => QuestionTurn(
        question: questions[index],
        playerId: assignments[index],
      ),
    );
  }

  void _shuffleNonOutFirst(List<String> assignments, String outPlayerId) {
    assignments.shuffle(_random);
    if (assignments.first != outPlayerId) {
      return;
    }

    final swapIndex = assignments.indexWhere((id) => id != outPlayerId);
    if (swapIndex == -1) {
      return;
    }

    final outAssignment = assignments[0];
    assignments[0] = assignments[swapIndex];
    assignments[swapIndex] = outAssignment;
  }
}
