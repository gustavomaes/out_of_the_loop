import 'dart:convert';
import '../../domain/classic/classic_models.dart';
import 'classic_content_repository.dart';

/// Strict Classic schema: concepts have stable IDs and localized values, no questions.
class ClassicCatalog {
  ClassicCatalog._(
    this.version,
    this.categories,
    this.words,
    this.legacyWordIds,
  );
  final String version;
  final List<ClassicCategory> categories;
  final List<ClassicWord> words;
  final Map<String, String> legacyWordIds;

  static ClassicCatalog parse(String source) {
    try {
      final data = jsonDecode(source) as Map<String, dynamic>;
      if (data['schemaVersion'] != 1) {
        throw const FormatException('Unknown schema');
      }
      String nonempty(dynamic value) {
        if (value is! String || value.trim().isEmpty || value != value.trim()) {
          throw const FormatException('Empty or untrimmed text');
        }
        return value;
      }

      final version = nonempty(data['catalogVersion']);
      final categories = <ClassicCategory>[];
      final words = <ClassicWord>[];
      final ids = <String>{};
      final categoryIds = <String>{};
      final keys = <String>{};
      for (final c in data['categories'] as List) {
        final category = nonempty(c['id']);
        if (!categoryIds.add(category) || c['premium'] is! bool) {
          throw const FormatException('Invalid category');
        }
        categories.add(
          ClassicCategory(
            category,
            nonempty(c['name']),
            nonempty(c['emoji']),
            premium: c['premium'] as bool,
          ),
        );
        final localIds = <String>{};
        final texts = <String>{};
        for (final w in c['words'] as List) {
          final id = nonempty(w['id']);
          if (!ids.add(id) ||
              w.containsKey('questions') ||
              w['commercialExample'] is! bool) {
            throw const FormatException('Invalid word');
          }
          localIds.add(id);
          final values = w['value'] as Map<String, dynamic>;
          if (!values.containsKey('en')) {
            throw const FormatException('Missing English');
          }
          for (final entry in values.entries) {
            if (!const {'en', 'pt-BR', 'es', 'hi', 'ar'}.contains(entry.key)) {
              throw const FormatException('Unknown language');
            }
            final text = nonempty(entry.value);
            if (!texts.add('${entry.key}/${text.toLowerCase()}')) {
              throw const FormatException('Duplicate localized word');
            }
            words.add(
              ClassicWord(
                id: id,
                categoryId: category,
                language: entry.key,
                text: text,
                commercialExample: w['commercialExample'] as bool,
              ),
            );
            keys.add('${entry.key}/$category/$id');
          }
        }
        if (localIds.isEmpty) throw const FormatException('Empty category');
        final examples = (c['paywallExampleIds'] as List).cast<String>();
        if (examples.isEmpty ||
            examples.toSet().length != examples.length ||
            examples.any(
              (id) =>
                  !localIds.contains(id) ||
                  !words.any((w) => w.id == id && w.commercialExample),
            )) {
          throw const FormatException('Invalid commercial references');
        }
      }
      if (categories.isEmpty) throw const FormatException('Empty catalog');
      final mapping = Map<String, String>.from(data['legacyWordIds'] as Map);
      for (final entry in mapping.entries) {
        final old = entry.key.split(':');
        if (old.length != 3 ||
            old.any((v) => v.isEmpty) ||
            !keys.contains(entry.value) ||
            !entry.value.startsWith('${old[0]}/')) {
          throw const FormatException('Invalid legacy reference');
        }
      }
      return ClassicCatalog._(
        version,
        List.unmodifiable(categories),
        List.unmodifiable(words),
        Map.unmodifiable(mapping),
      );
    } on FormatException {
      rethrow;
    } on Object {
      throw const FormatException('Malformed Classic catalog');
    }
  }
}
