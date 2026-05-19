import 'dart:math';

import '../models/models.dart';
import 'question_turn_planner.dart';

final class RoundGenerationService {
  RoundGenerationService({Random? random, QuestionTurnPlanner? questionTurnPlanner})
    : _random = random ?? Random(),
      _questionTurnPlanner = questionTurnPlanner ?? QuestionTurnPlanner(random: random);

  final Random _random;
  final QuestionTurnPlanner _questionTurnPlanner;

  RoundState generateRound({
    required int roundNumber,
    required List<Player> players,
    required int questionsPerPlayer,
    required List<SecretWord> categoryWords,
    required Set<String> usedWordIds,
  }) {
    if (!MatchSetup.isSupportedPlayerCount(players.length)) {
      throw StateError('Round generation requires 3 to 9 players.');
    }

    final questionsNeeded = players.length * questionsPerPlayer;
    final validWords = categoryWords
        .where(
          (word) =>
              !usedWordIds.contains(word.id) &&
              word.questions.length >= questionsNeeded,
        )
        .toList();
    if (validWords.isEmpty) {
      throw StateError('No playable words remain for this round.');
    }

    final outPlayer = players[_random.nextInt(players.length)];
    final secretWord = validWords[_random.nextInt(validWords.length)];
    final questions = secretWord.questions.take(questionsNeeded).toList();

    return RoundState(
      roundNumber: roundNumber,
      outPlayerId: outPlayer.id,
      secretWord: secretWord,
      questions: questions,
      questionTurns: _questionTurnPlanner.planTurns(
        players: players,
        questions: questions,
        outPlayerId: outPlayer.id,
      ),
      phase: RoundPhase.reveal,
    );
  }
}
