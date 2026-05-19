import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/content/local_content_repository.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/features/setup/category_selection_screen.dart';
import 'package:outoftheloop/src/features/setup/match_setup_screen.dart';
import 'package:outoftheloop/src/features/setup/player_setup_screen.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
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

    expect(find.text('Food & Drink'), findsOneWidget);
    expect(selectedCategory, isNull);

    await tester.tap(find.text('Food & Drink'));
    await tester.pump();

    expect(selectedCategory?.id, 'food');
  });

  testWidgets('match setup exposes round and question selectors', (
    tester,
  ) async {
    int? continuedRoundCount;
    int? continuedQuestionsPerPlayer;

    await tester.pumpWidget(
      _TestApp(
        child: MatchSetupScreen(
          onContinue: (roundCount, questionsPerPlayer) {
            continuedRoundCount = roundCount;
            continuedQuestionsPerPlayer = questionsPerPlayer;
          },
        ),
      ),
    );

    expect(find.text('CONFIGURAR PARTIDA'), findsOneWidget);
    expect(find.text('RODADAS NA PARTIDA'), findsOneWidget);
    expect(find.text('Rodadas: 3'), findsOneWidget);
    expect(find.text('2 perguntas'), findsOneWidget);
    expect(_buttonLabeled(tester, 'CONTINUE').enabled, isTrue);

    await tester.ensureVisible(find.byKey(const Key('round_count_5')));
    await tester.tap(find.byKey(const Key('round_count_5')));
    await tester.pumpAndSettle();
    expect(find.text('Rodadas: 5'), findsOneWidget);
    await tester.tap(find.text('3 perguntas'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('CONTINUE'));
    await tester.pump();

    expect(continuedRoundCount, 5);
    expect(continuedQuestionsPerPlayer, 3);
  });

  testWidgets('player setup enables start after third valid player', (
    tester,
  ) async {
    List<Player>? startedPlayers;
    int? startedRoundCount;
    int? startedQuestionsPerPlayer;

    await tester.pumpWidget(
      _TestApp(
        child: PlayerSetupScreen(
          roundCount: MatchSetup.recommendedRoundCount,
          questionsPerPlayer: 2,
          onStart: (players, roundCount, questionsPerPlayer) {
            startedPlayers = players;
            startedRoundCount = roundCount;
            startedQuestionsPerPlayer = questionsPerPlayer;
          },
        ),
      ),
    );

    expect(find.text('QUEM VAI JOGAR?'), findsOneWidget);
    expect(find.text('RODADAS NA PARTIDA'), findsNothing);
    expect(_buttonLabeled(tester, 'START MATCH').enabled, isFalse);

    for (final name in ['Ana', 'Bia', 'Caio']) {
      await tester.enterText(find.byType(TextField), name);
      await tester.tap(find.text('ADD'));
      await tester.pump();
    }

    expect(find.text('3/9 players ready'), findsOneWidget);
    expect(find.text('3 rodadas na partida'), findsOneWidget);
    expect(find.text('6 perguntas por rodada'), findsOneWidget);
    expect(_buttonLabeled(tester, 'START MATCH').enabled, isTrue);

    await tester.tap(find.text('START MATCH'));
    await tester.pump();

    expect(startedPlayers, hasLength(3));
    expect(startedRoundCount, MatchSetup.recommendedRoundCount);
    expect(startedQuestionsPerPlayer, 2);
    expect(startedPlayers!.map((player) => player.name).toList(), [
      'Caio',
      'Bia',
      'Ana',
    ]);
  });

  testWidgets('player setup passes custom round and question counts on start', (
    tester,
  ) async {
    int? startedRoundCount;
    int? startedQuestionsPerPlayer;

    await tester.pumpWidget(
      _TestApp(
        child: PlayerSetupScreen(
          roundCount: 5,
          questionsPerPlayer: 3,
          onStart: (_, roundCount, questionsPerPlayer) {
            startedRoundCount = roundCount;
            startedQuestionsPerPlayer = questionsPerPlayer;
          },
        ),
      ),
    );

    for (final name in ['Ana', 'Bia', 'Caio']) {
      await tester.enterText(find.byType(TextField), name);
      await tester.tap(find.text('ADD'));
      await tester.pump();
    }

    expect(find.text('5 rodadas na partida'), findsOneWidget);
    expect(find.text('9 perguntas por rodada'), findsOneWidget);

    await tester.tap(find.text('START MATCH'));
    await tester.pump();

    expect(startedRoundCount, 5);
    expect(startedQuestionsPerPlayer, 3);
  });

  testWidgets('player setup recommends one question for five players', (
    tester,
  ) async {
    await tester.pumpWidget(
      _TestApp(
        child: PlayerSetupScreen(
          roundCount: MatchSetup.recommendedRoundCount,
          questionsPerPlayer: 2,
        ),
      ),
    );

    for (var index = 1; index <= 5; index += 1) {
      await tester.enterText(find.byType(TextField), 'Player $index');
      await tester.tap(find.text('ADD'));
      await tester.pump();
    }

    expect(find.text('3 rodadas na partida'), findsOneWidget);
    expect(find.text('5 perguntas por rodada'), findsOneWidget);
  });

  testWidgets('player setup reports duplicate and tenth-player attempts', (
    tester,
  ) async {
    await tester.pumpWidget(
      _TestApp(
        child: PlayerSetupScreen(
          roundCount: MatchSetup.recommendedRoundCount,
          questionsPerPlayer: 2,
        ),
      ),
    );

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
    return MaterialApp(
      theme: OutOfTheLoopTheme.dark,
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    );
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
      "primary": "#B7F700",
      "secondary": "#D4FF66",
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
            { "id": "pizza-q1", "text": { "pt-BR": "Pergunta 1", "en": "Question 1", "es": "Pregunta 1", "hi": "Question 1" } },
            { "id": "pizza-q2", "text": { "pt-BR": "Pergunta 2", "en": "Question 2", "es": "Pregunta 2", "hi": "Question 2" } },
            { "id": "pizza-q3", "text": { "pt-BR": "Pergunta 3", "en": "Question 3", "es": "Pregunta 3", "hi": "Question 3" } },
            { "id": "pizza-q4", "text": { "pt-BR": "Pergunta 4", "en": "Question 4", "es": "Pregunta 4", "hi": "Question 4" } },
            { "id": "pizza-q5", "text": { "pt-BR": "Pergunta 5", "en": "Question 5", "es": "Pregunta 5", "hi": "Question 5" } },
            { "id": "pizza-q6", "text": { "pt-BR": "Pergunta 6", "en": "Question 6", "es": "Pregunta 6", "hi": "Question 6" } },
            { "id": "pizza-q7", "text": { "pt-BR": "Pergunta 7", "en": "Question 7", "es": "Pregunta 7", "hi": "Question 7" } },
            { "id": "pizza-q8", "text": { "pt-BR": "Pergunta 8", "en": "Question 8", "es": "Pregunta 8", "hi": "Question 8" } },
            { "id": "pizza-q9", "text": { "pt-BR": "Pergunta 9", "en": "Question 9", "es": "Pregunta 9", "hi": "Question 9" } }
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
