// Expands every word in assets/content/seed_content.json to 9 questions.
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('assets/content/seed_content.json');
  final seed = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final languages = (seed['languages'] as List<dynamic>).cast<String>();
  const targetCount = 9;

  final categories = seed['categories'] as List<dynamic>;
  var expandedWords = 0;

  for (final category in categories.cast<Map<String, dynamic>>()) {
    final words = category['words'] as List<dynamic>;
    for (final word in words.cast<Map<String, dynamic>>()) {
      final wordId = word['id'] as String;
      final value = (word['value'] as Map<String, dynamic>);
      final questions = (word['questions'] as List<dynamic>)
          .cast<Map<String, dynamic>>();

      if (questions.length >= targetCount) {
        continue;
      }

      final startIndex = questions.length + 1;
      for (var index = startIndex; index <= targetCount; index += 1) {
        questions.add(
          _question(
            id: '$wordId-q$index',
            templateIndex: index,
            value: value,
            languages: languages,
          ),
        );
      }

      word['questions'] = questions;
      expandedWords += 1;
    }
  }

  final encoder = JsonEncoder.withIndent('  ');
  file.writeAsStringSync('${encoder.convert(seed)}\n');
  print('Expanded $expandedWords words to $targetCount questions each.');
}

Map<String, dynamic> _question({
  required String id,
  required int templateIndex,
  required Map<String, dynamic> value,
  required List<String> languages,
}) {
  final text = <String, String>{};
  for (final language in languages) {
    final word = value[language]! as String;
    text[language] = _template(templateIndex, language, word);
  }
  return {'id': id, 'text': text};
}

String _template(int index, String language, String word) {
  return switch (index) {
    4 => switch (language) {
      'pt-BR' => 'Onde voce NAO esperaria encontrar $word?',
      'en' => 'Where would you NOT expect to find $word?',
      'es' => 'Donde NO esperarias encontrar $word?',
      'hi' => 'आप $word को कहाँ नहीं पाने की उम्मीद करेंगे?',
      _ => throw ArgumentError('Unsupported language: $language'),
    },
    5 => switch (language) {
      'pt-BR' => 'Que sentimento $word desperta em voce?',
      'en' => 'What feeling does $word bring up for you?',
      'es' => 'Que sentimiento te despierta $word?',
      'hi' => '$word आपमें किस भावना को जगाता है?',
      _ => throw ArgumentError('Unsupported language: $language'),
    },
    6 => switch (language) {
      'pt-BR' => 'O que voce precisa para aproveitar $word?',
      'en' => 'What do you need to enjoy $word?',
      'es' => 'Que necesitas para disfrutar $word?',
      'hi' => '$word का आनंद लेने के लिए आपको क्या चाहिए?',
      _ => throw ArgumentError('Unsupported language: $language'),
    },
    7 => switch (language) {
      'pt-BR' => '$word combina mais com dia ou noite?',
      'en' => 'Does $word fit better with day or night?',
      'es' => '$word encaja mejor de dia o de noche?',
      'hi' => '$word दिन या रात के साथ बेहतर फिट बैठता है?',
      _ => throw ArgumentError('Unsupported language: $language'),
    },
    8 => switch (language) {
      'pt-BR' => 'Criancas ou adultos curtem mais $word?',
      'en' => 'Do children or adults enjoy $word more?',
      'es' => 'Los ninos o los adultos disfrutan mas $word?',
      'hi' => 'बच्चे या बड़े $word का अधिक आनंद लेते हैं?',
      _ => throw ArgumentError('Unsupported language: $language'),
    },
    9 => switch (language) {
      'pt-BR' => 'Que cheiro ou som lembra $word para voce?',
      'en' => 'What smell or sound reminds you of $word?',
      'es' => 'Que olor o sonido te recuerda a $word?',
      'hi' => 'कौन सी गंध या आवाज़ आपको $word की याद दिलाती है?',
      _ => throw ArgumentError('Unsupported language: $language'),
    },
    _ => throw ArgumentError('Unsupported template index: $index'),
  };
}
