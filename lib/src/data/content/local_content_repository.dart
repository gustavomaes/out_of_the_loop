import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/models/models.dart';

class LocalContentRepository {
  LocalContentRepository({
    AssetBundle? bundle,
    this.assetPath = 'assets/content/seed_content.json',
    String? seedJson,
  }) : _bundle = bundle ?? rootBundle,
       _seedJson = seedJson;

  final AssetBundle _bundle;
  final String assetPath;
  final String? _seedJson;
  ContentSeed? _cache;

  Future<List<Category>> listCategories(SupportedLanguage language) async {
    final seed = await _load();
    seed.requireLanguage(language);
    return seed.categories.map((category) => category.category).toList();
  }

  Future<List<SecretWord>> wordsForCategory(
    String categoryId,
    SupportedLanguage language,
  ) async {
    final seed = await _load();
    seed.requireLanguage(language);
    final category = seed.categoryById(categoryId);
    return category.words;
  }

  Future<List<Question>> questionsForWord({
    required String categoryId,
    required String wordId,
    required SupportedLanguage language,
  }) async {
    final words = await wordsForCategory(categoryId, language);
    final word = words.where((word) => word.id == wordId).firstOrNull;
    if (word == null) {
      throw StateError('Missing word "$wordId" in category "$categoryId".');
    }
    return word.questions;
  }

  Future<ContentSeed> _load() async {
    final cached = _cache;
    if (cached != null) {
      return cached;
    }

    final rawJson = _seedJson ?? await _bundle.loadString(assetPath);
    final decoded = jsonDecode(rawJson);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Content seed must be a JSON object.');
    }
    return _cache = ContentSeed.fromJson(decoded);
  }
}

final class ContentSeed {
  ContentSeed({
    required this.schemaVersion,
    required Set<SupportedLanguage> languages,
    required List<ContentCategory> categories,
  }) : languages = Set.unmodifiable(languages),
       categories = List.unmodifiable(categories);

  factory ContentSeed.fromJson(Map<String, dynamic> json) {
    final schemaVersion = _intField(json, 'schemaVersion');
    if (schemaVersion != 1) {
      throw FormatException(
        'Unsupported content schema version $schemaVersion.',
      );
    }

    final languages = _languages(json);
    final minQuestions = _intField(json, 'minQuestionsPerWord');
    final maxQuestions = _intField(json, 'maxQuestionsPerWord');
    if (minQuestions < 1 || minQuestions > maxQuestions) {
      throw const FormatException('Invalid question boundaries.');
    }

    final categories = _objectList(json, 'categories')
        .map(
          (category) => ContentCategory.fromJson(
            category,
            languages: languages,
            minQuestions: minQuestions,
            maxQuestions: maxQuestions,
          ),
        )
        .toList();
    if (categories.isEmpty) {
      throw const FormatException('Content seed must include categories.');
    }

    return ContentSeed(
      schemaVersion: schemaVersion,
      languages: languages,
      categories: categories,
    );
  }

  final int schemaVersion;
  final Set<SupportedLanguage> languages;
  final List<ContentCategory> categories;

  void requireLanguage(SupportedLanguage language) {
    if (!languages.contains(language)) {
      throw FormatException('Missing content language ${language.code}.');
    }
  }

  ContentCategory categoryById(String id) {
    final category = categories
        .where((category) => category.category.id == id)
        .firstOrNull;
    if (category == null) {
      throw StateError('Missing category "$id".');
    }
    return category;
  }
}

final class ContentCategory {
  ContentCategory({required this.category, required List<SecretWord> words})
    : words = List.unmodifiable(words);

  factory ContentCategory.fromJson(
    Map<String, dynamic> json, {
    required Set<SupportedLanguage> languages,
    required int minQuestions,
    required int maxQuestions,
  }) {
    final id = _stringField(json, 'id');
    final words = _objectList(json, 'words')
        .map(
          (word) => _wordFromJson(
            word,
            categoryId: id,
            languages: languages,
            minQuestions: minQuestions,
            maxQuestions: maxQuestions,
          ),
        )
        .toList();
    if (words.isEmpty) {
      throw FormatException('Category "$id" must include words.');
    }

    return ContentCategory(
      category: Category(
        id: id,
        iconKey: _optionalStringField(json, 'iconKey'),
        name: _localizedText(json, 'name', languages),
      ),
      words: words,
    );
  }

  final Category category;
  final List<SecretWord> words;
}

SecretWord _wordFromJson(
  Map<String, dynamic> json, {
  required String categoryId,
  required Set<SupportedLanguage> languages,
  required int minQuestions,
  required int maxQuestions,
}) {
  final id = _stringField(json, 'id');
  final questions = _objectList(json, 'questions')
      .map(
        (question) => Question(
          id: _stringField(question, 'id'),
          wordId: id,
          text: _localizedText(question, 'text', languages),
        ),
      )
      .toList();
  if (questions.length < minQuestions || questions.length > maxQuestions) {
    throw FormatException(
      'Word "$id" must include between $minQuestions and $maxQuestions questions.',
    );
  }

  return SecretWord(
    id: id,
    categoryId: categoryId,
    value: _localizedText(json, 'value', languages),
    questions: questions,
  );
}

Set<SupportedLanguage> _languages(Map<String, dynamic> json) {
  final values = _stringList(json, 'languages');
  final languages = <SupportedLanguage>{};
  for (final value in values) {
    final language = SupportedLanguage.values
        .where((language) => language.code == value)
        .firstOrNull;
    if (language == null) {
      throw FormatException('Unsupported language "$value".');
    }
    languages.add(language);
  }
  if (languages.isEmpty) {
    throw const FormatException('Content seed must include languages.');
  }
  return languages;
}

LocalizedText _localizedText(
  Map<String, dynamic> json,
  String key,
  Set<SupportedLanguage> languages,
) {
  final value = json[key];
  if (value is! Map<String, dynamic>) {
    throw FormatException('$key must be a localized map.');
  }

  final entries = <SupportedLanguage, String>{};
  for (final language in languages) {
    final localizedValue = value[language.code];
    if (localizedValue is! String || localizedValue.isEmpty) {
      throw FormatException('$key is missing ${language.code} text.');
    }
    entries[language] = localizedValue;
  }
  return LocalizedText(entries);
}

List<String> _stringList(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is List<dynamic> && value.every((item) => item is String)) {
    return value.cast<String>();
  }
  throw FormatException('$key must be a string list.');
}

List<Map<String, dynamic>> _objectList(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is List<dynamic> &&
      value.every((item) => item is Map<String, dynamic>)) {
    return value.cast<Map<String, dynamic>>();
  }
  throw FormatException('$key must be an object list.');
}

int _intField(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is int) {
    return value;
  }
  throw FormatException('$key must be an integer.');
}

String _stringField(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is String && value.isNotEmpty) {
    return value;
  }
  throw FormatException('$key must be a non-empty string.');
}

String? _optionalStringField(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) {
    return null;
  }
  if (value is String && value.isNotEmpty) {
    return value;
  }
  throw FormatException('$key must be a non-empty string when provided.');
}
