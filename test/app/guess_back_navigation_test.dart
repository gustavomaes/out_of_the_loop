import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/out_of_the_loop_app.dart';
import 'package:outoftheloop/src/shared/widgets/otl_brutalist_discovery_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_test_helpers.dart';

void main() {
  testWidgets('back from reveal after guess does not show results placeholder', (
    tester,
  ) async {
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

    const splitVoteCardIndexes = [1, 2, 0];
    for (final cardIndex in splitVoteCardIndexes) {
      await tapVoteAtCardIndex(tester, cardIndex);
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('CONFIRM VOTES'));
    await tester.pumpAndSettle();

    final resultsScrollable = find.byType(Scrollable).first;
    final guessCta = find.text('GUESS THE WORD');
    await tester.scrollUntilVisible(
      guessCta,
      200,
      scrollable: resultsScrollable,
    );
    await tester.tap(guessCta);
    await tester.pumpAndSettle();

    await tester.tap(find.text('MISSED IT'));
    await tester.pumpAndSettle();

    expect(find.text('REVEAL MY ROLE'), findsOneWidget);

    final backButton = find.descendant(
      of: find.byType(OtlBrutalistDiscoveryAppBar),
      matching: find.byIcon(Icons.arrow_back),
    );
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(find.text('Leave the match?'), findsOneWidget);
    await tester.tap(find.text('KEEP PLAYING'));
    await tester.pumpAndSettle();

    expect(find.text('/game/results'), findsNothing);
    expect(find.text('REVEAL MY ROLE'), findsOneWidget);
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
  fail('Could not find $finder');
}
