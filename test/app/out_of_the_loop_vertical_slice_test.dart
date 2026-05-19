import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/out_of_the_loop_app.dart';

import 'app_test_helpers.dart';

void main() {
  testWidgets('plays a complete 3-player MVP vertical slice', (tester) async {
    setEnglishAppPreferences();

    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('START GAME'));
    await _pumpUntilVisible(tester, find.text('Food & Drink'));
    await tester.tap(find.text('Food & Drink'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    for (final name in ['Ana', 'Bia', 'Caio']) {
      await tester.enterText(find.byType(TextField), name);
      await tester.tap(find.text('ADD'));
      await tester.pump();
    }
    await tester.tap(find.text('START GAME', skipOffstage: false).last);
    await tester.pumpAndSettle();

    for (var index = 0; index < 3; index += 1) {
      expect(find.text('Make sure nobody else is'), findsOneWidget);
      expect(find.textContaining('OUT of the loop'), findsNothing);

      await tester.tap(find.text('REVEAL MY ROLE'));
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
      await tapFirstEnabledVote(tester);
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('CONFIRM VOTES'));
    await tester.pumpAndSettle();

    expect(find.text('THE OUT PLAYER WAS'), findsOneWidget);
    expect(find.text('VOTE TOTALS'), findsOneWidget);
    expect(find.text('ROUND POINTS'), findsOneWidget);
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
