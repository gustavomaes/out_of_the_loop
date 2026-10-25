import '../../domain/classic/classic_models.dart';
import 'classic_catalog.g.dart';
import 'classic_catalog_parser.dart';

/// Versioned offline catalog; generated from assets/content/classic_catalog.json.
class ClassicContentRepository {
  const ClassicContentRepository();
  static final catalog = ClassicCatalog.parse(classicCatalogJson);
  List<ClassicWord> wordsFor(ClassicConfig config) => catalog.words
      .where(
        (word) =>
            word.language == config.contentLanguage &&
            config.categoryIds.contains(word.categoryId),
      )
      .toList(growable: false);
}

class ClassicCategory {
  const ClassicCategory(this.id, this.name, this.emoji, {this.premium = false});
  final String id;
  final String name;
  final String emoji;
  final bool premium;
}

final classicCategories = ClassicContentRepository.catalog.categories;
