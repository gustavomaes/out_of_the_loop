import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/out_of_the_loop_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('plays a complete 3-player MVP vertical slice', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('START GAME'));
    await _pumpUntilVisible(tester, find.text('Comida'));
    await tester.tap(find.text('Comida'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('PLAY'));
    await tester.pumpAndSettle();

    for (final name in ['Ana', 'Bia', 'Caio']) {
      await tester.enterText(find.byType(TextField), name);
      await tester.tap(find.text('ADD'));
      await tester.pump();
    }
    await tester.tap(find.text('START MATCH'));
    await tester.pumpAndSettle();

    for (var index = 0; index < 3; index += 1) {
      expect(find.text('Make sure nobody else is looking.'), findsOneWidget);
      expect(find.textContaining('FORA'), findsNothing);

      await tester.tap(find.text('VIEW MY WORD'));
      await tester.pumpAndSettle();

      expect(find.text('Make sure nobody else is looking.'), findsNothing);

      await tester.tap(
        find.text(index == 2 ? 'START QUESTIONS' : 'NEXT PLAYER'),
      );
      await tester.pumpAndSettle();
    }

    for (var index = 0; index < 6; index += 1) {
      expect(
        find.text('QUESTION ${index + 1} OF 6'),
        findsOneWidget,
      );
      await tester.tap(
        find.text(index == 5 ? 'GO TO VOTING' : 'DONE ANSWERING'),
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

    expect(find.text('The out player was'), findsOneWidget);
    expect(find.text('Vote totals'), findsOneWidget);
    expect(find.text('Round points'), findsOneWidget);
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
  expect(finder, findsOneWidget);
}
