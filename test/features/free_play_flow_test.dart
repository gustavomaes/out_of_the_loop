import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/out_of_the_loop_app.dart';
import 'package:outoftheloop/src/features/game/free_clue_screen.dart';
import 'package:outoftheloop/src/features/game/widgets/active_player_banner.dart';
import 'package:outoftheloop/src/features/setup/widgets/game_mode_selector.dart';
import '../app/app_test_helpers.dart';

void main() {
  testWidgets(
    'free mode goes from roles through clues to voting without showing a question',
    (tester) async {
      setEnglishAppPreferences();
      await tester.pumpWidget(const OutOfTheLoopApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text('START GAME'));
      for (
        var i = 0;
        i < 50 && find.text('Food & Drink').evaluate().isEmpty;
        i++
      ) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump(const Duration(milliseconds: 100));
      }
      await tester.tap(find.text('Food & Drink'));
      await tester.pumpAndSettle();
      expect(find.byType(GameModeSelector), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('mode-free')));
      await tester.pump();
      await tester.tap(find.text('CONTINUE'));
      await tester.pumpAndSettle();
      for (final name in ['Alex', 'Sam', 'Jamie']) {
        await tester.enterText(find.byType(TextField), name);
        await tester.tap(find.text('ADD'));
        await tester.pump();
      }
      await tester.tap(find.text('START GAME').last);
      await tester.pumpAndSettle();
      for (var i = 0; i < 3; i++) {
        await tester.tap(find.text('REVEAL MY ROLE'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('YES, REVEAL'));
        await tester.pumpAndSettle();
        await tester.tap(find.text(i == 2 ? "I'M DONE" : 'NEXT PLAYER'));
        await tester.pumpAndSettle();
      }
      expect(find.byType(FreeClueScreen), findsOneWidget);
      final visited = <String>{};
      for (var i = 0; i < 3; i++) {
        visited.add(
          tester
              .widget<ActivePlayerBanner>(find.byType(ActivePlayerBanner))
              .player
              .id,
        );
        await tester.tap(find.text('Clue given'));
        await tester.pump();
      }
      expect(visited, hasLength(3));
      expect(find.text('Everyone has given a clue.'), findsOneWidget);
      await tester.tap(find.text('One more lap'));
      await tester.pump();
      expect(find.text('Clue given'), findsOneWidget);
      for (var i = 0; i < 3; i++) {
        await tester.tap(find.text('Clue given'));
        await tester.pump();
      }
      await tester.tap(find.text('Vote now'));
      await tester.pumpAndSettle();
      for (var i = 0; i < 3; i++) {
        await tapFirstEnabledVote(tester);
        await tester.pumpAndSettle();
      }
      await tester.tap(find.text('CONFIRM VOTES'));
      await tester.pumpAndSettle();
      expect(find.text('ROUND POINTS'), findsOneWidget);
    },
  );
}
