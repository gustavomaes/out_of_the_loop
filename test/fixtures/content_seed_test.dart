import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('seed content covers the full category and word target', () {
    final seed = _loadSeed();

    _validateSeed(seed);

    final categories = seed['categories'] as List<dynamic>;
    final firstCategory = categories.first as Map<String, dynamic>;
    final words = firstCategory['words'] as List<dynamic>;
    final firstWord = words.first as Map<String, dynamic>;
    final questions = firstWord['questions'] as List<dynamic>;

    expect(categories, hasLength(6));
    for (final category in categories.cast<Map<String, dynamic>>()) {
      expect(category['words'], hasLength(30));
    }
    expect(questions, hasLength(9));
  });

  test('every word includes nine localized questions with stable ids', () {
    final seed = _loadSeed();
    _validateSeed(seed);

    final categories = seed['categories'] as List<dynamic>;
    for (final category in categories.cast<Map<String, dynamic>>()) {
      for (final word in _objectList(category, 'words')) {
        final wordId = word['id'] as String;
        final questions = _objectList(word, 'questions');

        expect(questions, hasLength(9), reason: 'word "$wordId"');
        for (var index = 0; index < questions.length; index += 1) {
          expect(questions[index]['id'], '$wordId-q${index + 1}');
        }
      }
    }
  });

  test('schema declares expansion points for all MVP languages', () {
    final seed = _loadSeed();

    expect(seed['schemaVersion'], 1);
    expect(seed['languages'], ['pt-BR', 'en', 'es', 'hi']);
    expect(seed['minQuestionsPerWord'], 3);
    expect(seed['maxQuestionsPerWord'], 9);
  });

  test('questions never contain the secret word in any language', () {
    final seed = _loadSeed();
    final languages = _stringList(seed, 'languages');

    for (final category in _objectList(seed, 'categories')) {
      for (final word in _objectList(category, 'words')) {
        final values = (word['value'] as Map<String, dynamic>).values
            .cast<String>();
        for (final question in _objectList(word, 'questions')) {
          final text = question['text'] as Map<String, dynamic>;
          for (final language in languages) {
            final questionText = text[language] as String;
            for (final secret in values) {
              expect(
                _questionContainsWord(questionText, secret),
                isFalse,
                reason:
                    'word "${word['id']}" leaks "$secret" in $language: $questionText',
              );
            }
          }
        }
      }
    }
  });

  test('fixture validation rejects words with too few questions', () {
    final seed = _loadSeed();
    final categories = seed['categories'] as List<dynamic>;
    final firstCategory = categories.first as Map<String, dynamic>;
    final words = firstCategory['words'] as List<dynamic>;
    final firstWord = words.first as Map<String, dynamic>;

    final invalidWord = Map<String, dynamic>.from(firstWord)
      ..['questions'] = (firstWord['questions'] as List<dynamic>)
          .take(2)
          .toList();
    final invalidCategory = Map<String, dynamic>.from(firstCategory)
      ..['words'] = [invalidWord, ...words.skip(1)];
    final invalidSeed = Map<String, dynamic>.from(seed)
      ..['categories'] = [invalidCategory, ...categories.skip(1)];

    expect(() => _validateSeed(invalidSeed), throwsFormatException);
  });
}

Map<String, dynamic> _loadSeed() {
  final file = File('assets/content/seed_content.json');
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

void _validateSeed(Map<String, dynamic> seed) {
  final languages = _stringList(seed, 'languages');
  final minQuestions = _intField(seed, 'minQuestionsPerWord');
  final maxQuestions = _intField(seed, 'maxQuestionsPerWord');
  final categories = _objectList(seed, 'categories');

  if (languages.length != 4 || !languages.contains('pt-BR')) {
    throw const FormatException('Seed must include all MVP languages.');
  }
  if (minQuestions < 3 || maxQuestions > 9 || minQuestions > maxQuestions) {
    throw const FormatException('Question boundaries must stay within 3 to 9.');
  }
  if (categories.length != 6) {
    throw const FormatException('Seed must include exactly 6 categories.');
  }

  for (final category in categories) {
    _requireLocalizedMap(category, 'name', languages);
    _requireHexColor(category, 'primary');
    _requireHexColor(category, 'secondary');
    final words = _objectList(category, 'words');
    if (words.length != 30) {
      throw const FormatException('Each category must include exactly 30 words.');
    }

    for (final word in words) {
      _requireLocalizedMap(word, 'value', languages);
      final questions = _objectList(word, 'questions');
      if (questions.length < minQuestions) {
        throw FormatException(
          'Word ${word['id']} has fewer than $minQuestions questions.',
        );
      }
      if (questions.length > maxQuestions) {
        throw FormatException(
          'Word ${word['id']} has more than $maxQuestions questions.',
        );
      }
      for (final question in questions) {
        _requireLocalizedMap(question, 'text', languages);
      }
    }
  }
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

void _requireHexColor(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String || !RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(value)) {
    throw FormatException('$key must be a #RRGGBB color.');
  }
}

bool _questionContainsWord(String question, String word) {
  final normalizedQuestion = question
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\u0900-\u097F\s]'), '');
  final normalizedWord = word
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\u0900-\u097F\s]'), '');
  if (normalizedWord.isEmpty) {
    return false;
  }
  if (normalizedWord.contains(' ')) {
    return normalizedQuestion.contains(normalizedWord);
  }
  final pattern = RegExp(
    r'(^|[^a-z0-9\u0900-\u097F])'
    '${RegExp.escape(normalizedWord)}'
    r'([^a-z0-9\u0900-\u097F]|$)',
  );
  return pattern.hasMatch(normalizedQuestion);
}

void _requireLocalizedMap(
  Map<String, dynamic> json,
  String key,
  List<String> languages,
) {
  final value = json[key];
  if (value is! Map<String, dynamic>) {
    throw FormatException('$key must be a localized map.');
  }
  for (final language in languages) {
    final localizedValue = value[language];
    if (localizedValue is! String || localizedValue.isEmpty) {
      throw FormatException('$key is missing $language text.');
    }
  }
}
