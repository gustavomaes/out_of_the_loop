import 'dart:math';

import '../models/models.dart';
import '../models/play_history.dart';
import 'question_turn_planner.dart';

final class RoundGenerationService {
  RoundGenerationService({
    Random? random,
    QuestionTurnPlanner? questionTurnPlanner,
  }) : _random = random ?? Random(),
       _questionTurnPlanner =
           questionTurnPlanner ?? QuestionTurnPlanner(random: random);

  final Random _random;
  final QuestionTurnPlanner _questionTurnPlanner;

  RoundState generateRound({
    required int roundNumber,
    required List<Player> players,
    required int questionsPerPlayer,
    required List<SecretWord> categoryWords,
    required Set<String> usedWordIds,
    GameMode mode = GameMode.guided,
    SupportedLanguage language = SupportedLanguage.en,
    PlayHistory? history,
  }) {
    if (!MatchSetup.isSupportedPlayerCount(players.length)) {
      throw StateError('Round generation requires 3 to 9 players.');
    }

    final questionsNeeded = players.length * questionsPerPlayer;
    final validWords = categoryWords
        .where(
          (word) =>
              !usedWordIds.contains(word.id) &&
              (mode == GameMode.free ||
                  word.questions.length >= questionsNeeded),
        )
        .toList();
    if (validWords.isEmpty) {
      throw StateError('No playable words remain for this round.');
    }

    final outPlayer = players[_random.nextInt(players.length)];
    // Unseen first; after exhaustion the least recently seen word wins.
    validWords.shuffle(_random);
    int age(SecretWord word) =>
        history?.words.indexOf(
          PlayHistory.wordKey(language, word.categoryId, word.id),
        ) ??
        -1;
    validWords.sort((a, b) => age(a).compareTo(age(b)));
    final secretWord = validWords.first;
    final candidates = secretWord.questions.toList()..shuffle(_random);
    int questionAge(Question q) =>
        history?.questions.indexOf(
          PlayHistory.questionKey(
            language,
            secretWord.categoryId,
            secretWord.id,
            q.id,
            text: q.text.valueFor(language),
          ),
        ) ??
        -1;
    candidates.sort((a, b) => questionAge(a).compareTo(questionAge(b)));
    final questions = mode == GameMode.free
        ? <Question>[]
        : candidates.take(questionsNeeded).toList();

    return RoundState(
      roundNumber: roundNumber,
      outPlayerId: outPlayer.id,
      secretWord: secretWord,
      questions: questions,
      questionTurns: _questionTurnPlanner.planTurns(
        players: players,
        questions: questions,
        outPlayerId: outPlayer.id,
        questionsPerPlayer: questionsPerPlayer,
      ),
      phase: RoundPhase.reveal,
    );
  }
}
