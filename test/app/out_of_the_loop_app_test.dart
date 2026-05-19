import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/app_routes.dart';
import 'package:outoftheloop/src/app/out_of_the_loop_app.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('declares all MVP route names', () {
    expect(AppRoutes.all, const [
      '/',
      '/categories',
      '/match-setup',
      '/players',
      '/game/reveal',
      '/game/questions',
      '/game/vote',
      '/game/results',
      '/game/guess',
      '/game/final',
      '/how-to-play',
      '/settings',
    ]);
  });

  testWidgets('app boots into the initial route with dark shell', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();

    expect(find.text('OUT OF THE LOOP'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, isNot(Colors.white));
  });

  testWidgets('bottom navigation is scoped to discovery routes', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);

    Navigator.of(
      tester.element(find.byType(Scaffold)),
    ).pushNamed(AppRoutes.gameReveal);
    await tester.pumpAndSettle();

    expect(find.text('Secret Reveal'), findsWidgets);
    expect(find.byType(NavigationBar), findsNothing);
    expect(
      Theme.of(tester.element(find.byType(Scaffold))).scaffoldBackgroundColor,
      AppColors.backgroundPrimary,
    );
  });

  testWidgets('completes one 3-player round from the app shell', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('START GAME'));
    await _pumpUntilVisible(tester, find.text('Comida'));
    await tester.tap(find.text('Comida'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('PLAY'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    for (final name in ['Ana', 'Bia', 'Caio']) {
      await tester.enterText(find.byType(TextField), name);
      await tester.tap(find.text('ADD'));
      await tester.pump();
    }
    await tester.tap(find.text('START MATCH'));
    await tester.pumpAndSettle();

    for (var index = 0; index < 3; index += 1) {
      await tester.tap(find.text('VIEW MY WORD'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.text(index == 2 ? 'START QUESTIONS' : 'NEXT PLAYER'),
      );
      await tester.pumpAndSettle();
    }

    for (var index = 0; index < 6; index += 1) {
      await tester.tap(find.text('DONE ANSWERING'));
      await tester.pump();
      await tester.tap(
        find.text(index == 5 ? 'GO TO VOTING' : 'NEXT QUESTION'),
      );
      await tester.pumpAndSettle();
    }

    for (var index = 0; index < 3; index += 1) {
      await tester.tap(find.text('VOTE').first);
      await tester.pump();
      await tester.tap(find.text('CONFIRM VOTE'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('CONFIRM VOTES'));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Scrollable).first, const Offset(0, -600));
    await tester.pumpAndSettle();

    if (find.text('GUESS WORD').evaluate().isNotEmpty) {
      await tester.tap(find.text('GUESS WORD'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('ERROU'));
      await tester.pumpAndSettle();
    } else {
      await tester.tap(find.text('CONTINUE'));
      await tester.pumpAndSettle();
    }

    expect(find.text('TOP SECRET'), findsOneWidget);
    expect(find.text('Caio\'s turn'), findsOneWidget);
  });

  testWidgets('restores saved language and timer preferences on startup', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'settings.language': 'en',
      'settings.timer.enabled': false,
      'settings.timer.durationSeconds': 45,
    });

    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();

    Navigator.of(
      tester.element(find.byType(Scaffold)),
    ).pushNamed(AppRoutes.settings);
    await tester.pumpAndSettle();

    expect(find.text('English'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('TIMER'), 200);
    expect(find.text('Use timer'), findsOneWidget);
    await tester.tap(find.text('Use timer'));
    await tester.pumpAndSettle();
    expect(find.textContaining('45 seconds per turn'), findsOneWidget);
  });
}

Future<void> _pumpUntilVisible(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 50; attempt += 1) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) {
      return;
    }
  }
  final visibleText = tester
      .widgetList<Text>(find.byType(Text))
      .map((text) => text.data)
      .whereType<String>()
      .join(', ');
  fail('Could not find $finder. Visible text: $visibleText');
}
