import '../models/models.dart';

enum MatchSetupValidationError {
  tooFewPlayers,
  tooManyPlayers,
  emptyPlayerName,
  duplicatePlayerName,
  invalidRoundCount,
  insufficientPlayableWords,
}

final class MatchSetupValidationResult {
  MatchSetupValidationResult({required List<MatchSetupValidationError> errors})
    : errors = List.unmodifiable(errors);

  final List<MatchSetupValidationError> errors;

  bool get canStart => errors.isEmpty;
}

final class MatchSetupService {
  const MatchSetupService();

  MatchSetupValidationResult validate({
    required List<Player> players,
    required int roundCount,
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

    final playableWords = categoryWords
        .where((word) => word.questions.length >= players.length)
        .length;
    if (roundCount > playableWords) {
      errors.add(MatchSetupValidationError.insufficientPlayableWords);
    }

    return MatchSetupValidationResult(errors: errors);
  }
}
