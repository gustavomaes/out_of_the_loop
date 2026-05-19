import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/out_of_the_loop_app.dart';

import 'app_test_helpers.dart';

void main() {
  testWidgets('starts a 3-player round without login or network setup', (
    tester,
  ) async {
    setEnglishAppPreferences();

    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Login'), findsNothing);

    await tester.tap(find.text('START GAME'));
    await _pumpUntilVisible(tester, find.text('Food & Drink'));

    expect(find.text('Food & Drink'), findsOneWidget);
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

    expect(find.text('TOP SECRET'), findsOneWidget);
    expect(find.textContaining('Login'), findsNothing);
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
