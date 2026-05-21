import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/domain/services/question_turn_planner.dart';

void main() {
  group('QuestionTurnPlanner', () {
    test('assigns each player the configured number of turns', () {
      final players = _players(3);
      final questions = _questions(6);
      final planner = QuestionTurnPlanner(random: Random(7));

      final turns = planner.planTurns(
        players: players,
        questions: questions,
        outPlayerId: 'p1',
      );

      expect(turns, hasLength(6));
      final counts = <String, int>{};
      for (final turn in turns) {
        counts.update(turn.playerId, (value) => value + 1, ifAbsent: () => 1);
      }
      expect(counts, {'p0': 2, 'p1': 2, 'p2': 2});
    });

    test('never assigns the out player as the first responder', () {
      final players = _players(4);
      final questions = _questions(8);
      final planner = QuestionTurnPlanner(random: Random(1));

      for (var attempt = 0; attempt < 25; attempt += 1) {
        final turns = planner.planTurns(
          players: players,
          questions: questions,
          outPlayerId: 'p2',
        );

        expect(turns.first.playerId, isNot('p2'));
      }
    });

    test('does not follow fixed player list order', () {
      final players = _players(3);
      final questions = _questions(6);
      final planner = QuestionTurnPlanner(random: Random(4));

      final turns = planner.planTurns(
        players: players,
        questions: questions,
        outPlayerId: 'p1',
      );

      expect(turns.map((turn) => turn.playerId).toList(), isNot(['p0', 'p1', 'p2', 'p0', 'p1', 'p2']));
    });
  });
}

List<Player> _players(int count) => List.generate(
  count,
  (index) => Player(id: 'p$index', name: 'Player $index', avatarSeed: 'seed-$index'),
);

List<Question> _questions(int count) => List.generate(
  count,
  (index) => Question(
    id: 'q$index',
    wordId: 'pizza',
    text: LocalizedText({
      SupportedLanguage.ptBr: 'Question ${index + 1}',
      SupportedLanguage.en: 'Question ${index + 1}',
      SupportedLanguage.es: 'Question ${index + 1}',
      SupportedLanguage.hi: 'Question ${index + 1}',
      SupportedLanguage.ar: 'Question ${index + 1}',
    }),
  ),
);
