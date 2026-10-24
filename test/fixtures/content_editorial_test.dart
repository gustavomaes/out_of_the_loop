import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'both banks keep nine localized prompts per word without text reuse',
    () {
      final seen = <String, String>{};
      final wordIds = <String>{};
      final questionIds = <String>{};
      for (final asset in ['seed_content.json', 'us_game_night.json']) {
        final seed =
            jsonDecode(File('assets/content/$asset').readAsStringSync())
                as Map<String, dynamic>;
        final languages = (seed['languages'] as List).cast<String>();
        expect(
          languages,
          asset == 'seed_content.json'
              ? ['pt-BR', 'en', 'es', 'hi', 'ar']
              : ['en'],
        );
        for (final category in seed['categories'] as List) {
          for (final word in category['words'] as List) {
            final wordId = word['id'] as String;
            expect(wordIds.add(wordId), isTrue, reason: wordId);
            final questions = word['questions'] as List;
            expect(questions, hasLength(9), reason: wordId);
            for (var index = 0; index < questions.length; index++) {
              final question = questions[index] as Map<String, dynamic>;
              final questionId = question['id'] as String;
              expect(questionId, '$wordId-q${index + 1}');
              expect(questionIds.add(questionId), isTrue, reason: questionId);
              final text = question['text'] as Map<String, dynamic>;
              expect(text.keys.toSet(), languages.toSet(), reason: questionId);
              for (final language in languages) {
                final value = text[language] as String;
                expect(
                  value.trim(),
                  isNotEmpty,
                  reason: '$questionId/$language',
                );
                final normalized = value
                    .toLowerCase()
                    .replaceAll(
                      RegExp(r'''[.,!?¿¡؟،؛:;'"“”‘’()\[\]{}—–-]'''),
                      '',
                    )
                    .replaceAll(RegExp(r'\s+'), ' ')
                    .trim();
                final key = '$language/$normalized';
                expect(
                  seen.containsKey(key),
                  isFalse,
                  reason:
                      '$questionId repeats ${seen[key]} in $language: $value',
                );
                seen[key] = questionId;
              }
            }
          }
        }
      }
      expect(wordIds, hasLength(240));
      expect(questionIds, hasLength(2160));
      expect(seen, hasLength(8640));
    },
  );
}
