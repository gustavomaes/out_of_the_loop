import 'dart:math';

import '../models/models.dart';

final class RoundGenerationService {
  RoundGenerationService({Random? random}) : _random = random ?? Random();

  final Random _random;

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

    return RoundState(
      roundNumber: roundNumber,
      outPlayerId: outPlayer.id,
      secretWord: secretWord,
      questions: secretWord.questions.take(questionsNeeded).toList(),
      phase: RoundPhase.reveal,
    );
  }
}
