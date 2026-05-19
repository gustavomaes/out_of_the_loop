import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';

extension CategoryLocalization on AppLocalizations {
  String categoryDisplayName({
    required String categoryId,
    required LocalizedText fallback,
    required SupportedLanguage language,
  }) {
    final label = switch (categoryId) {
      'food' => categoryFoodAndDrink,
      'travel' => categoryTravel,
      'movies' => categoryMovies,
      'animals' => categoryAnimals,
      'sports' => categorySports,
      'technology' => categoryTech,
      _ => null,
    };
    return label ?? fallback.valueFor(language);
  }
}
