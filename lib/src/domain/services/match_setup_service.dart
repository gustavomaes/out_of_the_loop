import '../models/models.dart';

enum MatchSetupValidationError {
  tooFewPlayers,
  tooManyPlayers,
  emptyPlayerName,
  duplicatePlayerName,
  invalidRoundCount,
  invalidQuestionsPerPlayer,
  insufficientPlayableWords,
  insufficientQuestionsPerWord,
}

final class MatchSetupValidationResult {
  MatchSetupValidationResult({required List<MatchSetupValidationError> errors})
    : errors = List.unmodifiable(errors);

  final List<MatchSetupValidationError> errors;

  bool get canStart => errors.isEmpty;
}

final class MatchSetupService {
  const MatchSetupService();

  static int recommendedQuestionsPerPlayer(int playerCount) {
    if (playerCount <= 4) {
      return 2;
    }
    return 1;
  }

  static int maxRoundCountFor({
    required int playerCount,
    required int questionsPerPlayer,
    required List<SecretWord> categoryWords,
  }) {
    if (categoryWords.isEmpty) {
      return MatchSetup.minRoundCount;
    }

    final effectivePlayerCount = playerCount < MatchSetup.minPlayers
        ? MatchSetup.minPlayers
        : playerCount;
    final questionsNeeded = effectivePlayerCount * questionsPerPlayer;
    final playableWords = categoryWords
        .where((word) => word.questions.length >= questionsNeeded)
        .length;

    return playableWords.clamp(
      MatchSetup.minRoundCount,
      MatchSetup.maxRoundCount,
    );
  }

  static int effectiveRoundCount({
    required int roundCount,
    required int maxRoundCount,
    required bool touched,
  }) {
    final recommended = MatchSetup.recommendedRoundCount.clamp(
      MatchSetup.minRoundCount,
      maxRoundCount,
    );
    if (!touched) {
      return recommended;
    }
    return roundCount.clamp(MatchSetup.minRoundCount, maxRoundCount);
  }

  static int maxQuestionsPerPlayerFor({
    required int playerCount,
    required List<SecretWord> categoryWords,
  }) {
    if (playerCount < 1 || categoryWords.isEmpty) {
      return MatchSetup.maxQuestionsPerPlayer;
    }

    var capacity = MatchSetup.maxQuestionsPerPlayer;
    for (final word in categoryWords) {
      if (word.questions.isEmpty) {
        continue;
      }
      final wordCapacity = word.questions.length ~/ playerCount;
      if (wordCapacity < capacity) {
        capacity = wordCapacity;
      }
    }
    return capacity.clamp(
      MatchSetup.minQuestionsPerPlayer,
      MatchSetup.maxQuestionsPerPlayer,
    );
  }

  MatchSetupValidationResult validate({
    required List<Player> players,
    required int roundCount,
    required int questionsPerPlayer,
    required List<SecretWord> categoryWords,
  }) {
    final errors = <MatchSetupValidationError>[];

    if (players.length < MatchSetup.minPlayers) {
      errors.add(MatchSetupValidationError.tooFewPlayers);
    }
    if (players.length > MatchSetup.maxPlayers) {
      errors.add(MatchSetupValidationError.tooManyPlayers);
    }

    final normalizedNames = <String>{};
    for (final player in players) {
      final normalizedName = player.name.trim().toLowerCase();
      if (normalizedName.isEmpty) {
        errors.add(MatchSetupValidationError.emptyPlayerName);
      } else if (!normalizedNames.add(normalizedName)) {
        errors.add(MatchSetupValidationError.duplicatePlayerName);
      }
    }

    if (roundCount < 1) {
      errors.add(MatchSetupValidationError.invalidRoundCount);
    }

    if (questionsPerPlayer < MatchSetup.minQuestionsPerPlayer ||
        questionsPerPlayer > MatchSetup.maxQuestionsPerPlayer) {
      errors.add(MatchSetupValidationError.invalidQuestionsPerPlayer);
    }

    final questionsNeeded = players.length * questionsPerPlayer;
    final playableWords = categoryWords
        .where((word) => word.questions.length >= questionsNeeded)
        .length;
    if (roundCount > playableWords) {
      errors.add(MatchSetupValidationError.insufficientPlayableWords);
    }
    if (players.isNotEmpty &&
        questionsPerPlayer >
            maxQuestionsPerPlayerFor(
              playerCount: players.length,
              categoryWords: categoryWords,
            )) {
      errors.add(MatchSetupValidationError.insufficientQuestionsPerWord);
    }

    return MatchSetupValidationResult(errors: errors);
  }
}
