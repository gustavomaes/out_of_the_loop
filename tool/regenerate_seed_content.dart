// Regenerates assets/content/seed_content.json with 6 categories, 30 words each,
// and questions that never contain the secret word in any language.
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

const _languages = ['pt-BR', 'en', 'es', 'hi'];
const _categoryIds = ['food', 'movies', 'sports', 'music', 'travel', 'animals'];
const _questionsPerWord = 9;

const _questionTemplates = <Map<String, String>>[
    {
      'pt-BR': 'Em que situacao voce usaria ou encontraria isso?',
      'en': 'In what situation would you use or find this?',
      'es': 'En que situacion usarias o encontrarias esto?',
      'hi': 'आप किस स्थिति में इसका उपयोग करेंगे या इसे पाएंगे?',
    },
    {
      'pt-BR': 'Que detalhe faz isso ser reconhecivel para voce?',
      'en': 'What detail makes this recognizable to you?',
      'es': 'Que detalle hace que esto sea reconocible para ti?',
      'hi': 'कौन सा विवरण इसे आपके लिए पहचानने योग्य बनाता है?',
    },
    {
      'pt-BR': 'Com quem voce associaria isso em uma conversa?',
      'en': 'Who would you associate this with in a conversation?',
      'es': 'Con quien asociarias esto en una conversacion?',
      'hi': 'बातचीत में आप इसे किससे जोड़ेंगे?',
    },
    {
      'pt-BR': 'Onde voce NAO esperaria encontrar isso?',
      'en': 'Where would you NOT expect to find this?',
      'es': 'Donde NO esperarias encontrar esto?',
      'hi': 'आप इसे कहाँ नहीं पाने की उम्मीद करेंगे?',
    },
    {
      'pt-BR': 'Que sentimento isso desperta em voce?',
      'en': 'What feeling does this bring up for you?',
      'es': 'Que sentimiento te despierta esto?',
      'hi': 'यह आपमें किस भावना को जगाता है?',
    },
    {
      'pt-BR': 'O que voce precisa para aproveitar isso?',
      'en': 'What do you need to enjoy this?',
      'es': 'Que necesitas para disfrutar esto?',
      'hi': 'इसका आनंद लेने के लिए आपको क्या चाहिए?',
    },
    {
      'pt-BR': 'Isso combina mais com dia ou noite?',
      'en': 'Does this fit better with day or night?',
      'es': 'Esto encaja mejor de dia o de noche?',
      'hi': 'यह दिन या रात के साथ बेहतर फिट बैठता है?',
    },
    {
      'pt-BR': 'Criancas ou adultos curtem mais isso?',
      'en': 'Do children or adults enjoy this more?',
      'es': 'Los ninos o los adultos disfrutan mas esto?',
      'hi': 'बच्चे या बड़े इसका अधिक आनंद लेते हैं?',
    },
    {
      'pt-BR': 'Que cheiro ou som lembra isso para voce?',
      'en': 'What smell or sound reminds you of this?',
      'es': 'Que olor o sonido te recuerda a esto?',
      'hi': 'कौन सी गंध या आवाज़ आपको इसकी याद दिलाती है?',
    },
];

void main() {
  final localizationsFile = File('tool/data/word_localizations.json');
  final localizations =
      (jsonDecode(localizationsFile.readAsStringSync()) as Map<String, dynamic>)
          .map(
            (key, value) => MapEntry(
              key,
              (value as Map<String, dynamic>).cast<String, String>(),
            ),
          );

  final sourceFile = File('assets/content/seed_content.json');
  final source = jsonDecode(sourceFile.readAsStringSync()) as Map<String, dynamic>;
  final sourceCategories =
      (source['categories'] as List<dynamic>).cast<Map<String, dynamic>>();
  final byId = {for (final c in sourceCategories) c['id'] as String: c};

  final categories = <Map<String, dynamic>>[];
  for (final categoryId in _categoryIds) {
    final category = byId[categoryId];
    if (category == null) {
      throw StateError('Missing category $categoryId in source seed.');
    }
    final words = (category['words'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    if (words.length < 30) {
      throw StateError('Category $categoryId has fewer than 30 words.');
    }

    final rebuiltWords = <Map<String, dynamic>>[];
    for (final word in words.take(30)) {
      final wordId = word['id'] as String;
      final localized = localizations[wordId];
      if (localized == null) {
        throw StateError('Missing localization for word "$wordId".');
      }
      final value = localized;
      final questions = <Map<String, dynamic>>[];

      for (var index = 0; index < _questionsPerWord; index += 1) {
        final template = _questionTemplates[index];
        final text = <String, String>{};
        for (final language in _languages) {
          text[language] = template[language]!;
        }
        _assertNoWordLeak(wordId: wordId, value: value, text: text);
        questions.add({
          'id': '$wordId-q${index + 1}',
          'text': text,
        });
      }

      rebuiltWords.add({
        'id': wordId,
        'value': value,
        'questions': questions,
      });
    }

    categories.add({
      'id': category['id'],
      'iconKey': category['iconKey'],
      'name': category['name'],
      'words': rebuiltWords,
      'primary': category['primary'],
      'secondary': category['secondary'],
    });
  }

  final seed = <String, dynamic>{
    'schemaVersion': source['schemaVersion'],
    'languages': _languages,
    'minQuestionsPerWord': source['minQuestionsPerWord'],
    'maxQuestionsPerWord': source['maxQuestionsPerWord'],
    'categories': categories,
  };

  _validateSeed(seed);

  final encoder = JsonEncoder.withIndent('  ');
  sourceFile.writeAsStringSync('${encoder.convert(seed)}\n');

  final wordCount = categories.length * 30;
  print(
    'Wrote ${categories.length} categories, $wordCount words, '
    '$_questionsPerWord questions each (no word leaks).',
  );
}

void _assertNoWordLeak({
  required String wordId,
  required Map<String, String> value,
  required Map<String, String> text,
}) {
  for (final entry in text.entries) {
    for (final word in value.values) {
      if (_containsWord(entry.value, word)) {
        throw StateError(
          'Question leaks word "$word" for $wordId (${entry.key}): ${entry.value}',
        );
      }
    }
  }
}

bool _containsWord(String question, String word) {
  final normalizedQuestion = _normalize(question);
  final normalizedWord = _normalize(word);
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

String _normalize(String input) =>
    input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9\u0900-\u097F\s]'), '');

void _validateSeed(Map<String, dynamic> seed) {
  final categories = seed['categories'] as List<dynamic>;
  if (categories.length != 6) {
    throw StateError('Expected 6 categories, got ${categories.length}.');
  }
  for (final category in categories.cast<Map<String, dynamic>>()) {
    final words = category['words'] as List<dynamic>;
    if (words.length != 30) {
      throw StateError(
        'Category ${category['id']} must have 30 words, got ${words.length}.',
      );
    }
  }
}
