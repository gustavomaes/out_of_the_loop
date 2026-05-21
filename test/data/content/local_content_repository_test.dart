import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/content/local_content_repository.dart';
import 'package:outoftheloop/src/domain/models/models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocalContentRepository', () {
    test('lists localized categories from injected local content', () async {
      final repository = LocalContentRepository(seedJson: _validSeedJson());

      final categories = await repository.listCategories(SupportedLanguage.en);

      expect(categories, hasLength(1));
      expect(categories.single.id, 'food');
      expect(categories.single.name.valueFor(SupportedLanguage.en), 'Food');
      expect(categories.single.iconKey, 'restaurant');
    });

    test('bundled content exposes 6 categories with 30 localized words each', () async {
      final repository = LocalContentRepository();

      final categories = await repository.listCategories(SupportedLanguage.en);

      expect(categories, hasLength(6));
      expect(categories.first.id, 'food');
      for (final category in categories) {
        final words = await repository.wordsForCategory(
          category.id,
          SupportedLanguage.hi,
        );
        expect(words, hasLength(30));
        expect(category.name.valueFor(SupportedLanguage.hi), isNotEmpty);
        expect(words.first.value.valueFor(SupportedLanguage.hi), isNotEmpty);
        expect(words.first.questions, hasLength(9));
        expect(
          words.first.questions.first.text.valueFor(SupportedLanguage.hi),
          isNotEmpty,
        );
        for (final word in words) {
          expect(word.questions, hasLength(9));
        }
      }
    });

    test('returns words and questions by category and locale', () async {
      final repository = LocalContentRepository(seedJson: _validSeedJson());

      final words = await repository.wordsForCategory(
        'food',
        SupportedLanguage.ptBr,
      );
      final questions = await repository.questionsForWord(
        categoryId: 'food',
        wordId: 'pizza',
        language: SupportedLanguage.ptBr,
      );

      expect(words.single.value.valueFor(SupportedLanguage.ptBr), 'Pizza');
      expect(questions, hasLength(3));
      expect(
        questions.first.text.valueFor(SupportedLanguage.ptBr),
        'Quando voce comeria isto?',
      );
    });

    test('throws StateError for missing category or word', () async {
      final repository = LocalContentRepository(seedJson: _validSeedJson());

      expect(
        () => repository.wordsForCategory('missing', SupportedLanguage.en),
        throwsStateError,
      );
      expect(
        () => repository.questionsForWord(
          categoryId: 'food',
          wordId: 'missing',
          language: SupportedLanguage.en,
        ),
        throwsStateError,
      );
    });

    test('throws FormatException for invalid schema and malformed content', () {
      expect(
        () => LocalContentRepository(
          seedJson: jsonEncode({'schemaVersion': 2}),
        ).listCategories(SupportedLanguage.en),
        throwsFormatException,
      );

      final malformed = _validSeed()
        ..['categories'] = [
          {
            'id': 'food',
            'iconKey': 'restaurant',
            'primary': '#B7F700',
            'secondary': '#D4FF66',
            'name': _localized('Food'),
            'words': <Map<String, Object?>>[],
          },
        ];

      expect(
        () => LocalContentRepository(
          seedJson: jsonEncode(malformed),
        ).listCategories(SupportedLanguage.en),
        throwsFormatException,
      );
    });
  });
}

String _validSeedJson() => jsonEncode(_validSeed());

Map<String, Object?> _validSeed() {
  return {
    'schemaVersion': 1,
    'languages': ['pt-BR', 'en', 'es', 'hi', 'ar'],
    'minQuestionsPerWord': 3,
    'maxQuestionsPerWord': 9,
    'categories': [
      {
        'id': 'food',
        'iconKey': 'restaurant',
        'primary': '#B7F700',
        'secondary': '#D4FF66',
        'name': {
          'pt-BR': 'Comida',
          'en': 'Food',
          'es': 'Comida',
          'hi': 'खाना',
          'ar': 'طعام',
        },
        'words': [
          {
            'id': 'pizza',
            'value': _localized('Pizza'),
            'questions': [
              {
                'id': 'pizza-q1',
                'text': {
                  'pt-BR': 'Quando voce comeria isto?',
                  'en': 'When would you eat this?',
                  'es': 'Cuando comerias esto?',
                  'hi': 'आप इसे कब खाएंगे?',
                  'ar': 'متى ستأكل هذا؟',
                },
              },
              {'id': 'pizza-q2', 'text': _localized('Best topping?')},
              {'id': 'pizza-q3', 'text': _localized('Party food?')},
            ],
          },
        ],
      },
    ],
  };
}

Map<String, String> _localized(String value) => {
  'pt-BR': value,
  'en': value,
  'es': value,
  'hi': value,
  'ar': value,
};
