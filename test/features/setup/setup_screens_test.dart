import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/content/local_content_repository.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/features/setup/category_selection_screen.dart';
import 'package:outoftheloop/src/features/setup/player_setup_screen.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  testWidgets('category screen renders local categories and selection', (
    tester,
  ) async {
    Category? selectedCategory;

    await tester.pumpWidget(
      _TestApp(
        child: CategorySelectionScreen(
          repository: LocalContentRepository(seedJson: _seedJson),
          onContinue: (category) => selectedCategory = category,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Comida'), findsOneWidget);
    expect(selectedCategory, isNull);

    await tester.tap(find.text('Comida'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('PLAY'));
    await tester.pump();

    expect(selectedCategory?.id, 'food');
  });

  testWidgets('player setup enables start after third valid player', (
    tester,
  ) async {
    List<Player>? startedPlayers;

    await tester.pumpWidget(
      _TestApp(
        child: PlayerSetupScreen(
          onStart: (players, questionsPerPlayer) => startedPlayers = players,
        ),
      ),
    );

    expect(_buttonLabeled(tester, 'START MATCH').enabled, isFalse);

    for (final name in ['Ana', 'Bia', 'Caio']) {
      await tester.enterText(find.byType(TextField), name);
      await tester.tap(find.text('ADD'));
      await tester.pump();
    }

    expect(find.text('3/9 players ready'), findsOneWidget);
    expect(find.text('6 perguntas nesta rodada'), findsOneWidget);
    expect(find.text('2 perguntas'), findsOneWidget);
    expect(_buttonLabeled(tester, 'START MATCH').enabled, isTrue);

    await tester.tap(find.text('START MATCH'));
    await tester.pump();

    expect(startedPlayers, hasLength(3));
  });

  testWidgets('player setup reports duplicate and tenth-player attempts', (
    tester,
  ) async {
    await tester.pumpWidget(_TestApp(child: PlayerSetupScreen()));

    await tester.enterText(find.byType(TextField), 'Ana');
    await tester.tap(find.text('ADD'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Ana');
    await tester.tap(find.text('ADD'));
    await tester.pump();

    expect(find.text('Player names must be unique.'), findsOneWidget);

    for (var index = 2; index <= 10; index += 1) {
      await tester.enterText(find.byType(TextField), 'Player $index');
      await tester.tap(find.text('ADD'));
      await tester.pump();
    }

    expect(find.text('A match supports up to 9 players.'), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: OutOfTheLoopTheme.dark, home: child);
  }
}

const _seedJson = '''
{
  "schemaVersion": 1,
  "languages": ["pt-BR", "en", "es", "hi"],
  "minQuestionsPerWord": 3,
  "maxQuestionsPerWord": 9,
  "categories": [
    {
      "id": "food",
      "iconKey": "restaurant",
      "name": {
        "pt-BR": "Comida",
        "en": "Food",
        "es": "Comida",
        "hi": "Food"
      },
      "words": [
        {
          "id": "pizza",
          "value": {
            "pt-BR": "Pizza",
            "en": "Pizza",
            "es": "Pizza",
            "hi": "Pizza"
          },
          "questions": [
            {
              "id": "q1",
              "text": {
                "pt-BR": "Pergunta 1",
                "en": "Question 1",
                "es": "Pregunta 1",
                "hi": "Question 1"
              }
            },
            {
              "id": "q2",
              "text": {
                "pt-BR": "Pergunta 2",
                "en": "Question 2",
                "es": "Pregunta 2",
                "hi": "Question 2"
              }
            },
            {
              "id": "q3",
              "text": {
                "pt-BR": "Pergunta 3",
                "en": "Question 3",
                "es": "Pregunta 3",
                "hi": "Question 3"
              }
            }
          ]
        }
      ]
    }
  ]
}
''';

TextButton _buttonLabeled(WidgetTester tester, String label) {
  return tester.widget<TextButton>(
    find.ancestor(of: find.text(label), matching: find.byType(TextButton)),
  );
}
