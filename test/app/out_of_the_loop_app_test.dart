import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/app_routes.dart';
import 'package:outoftheloop/src/app/out_of_the_loop_app.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  test('declares all MVP route names', () {
    expect(AppRoutes.all, const [
      '/',
      '/categories',
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
}
