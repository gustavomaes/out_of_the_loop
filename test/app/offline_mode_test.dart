import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/out_of_the_loop_app.dart';

void main() {
  testWidgets('starts a 3-player round without login or network setup', (
    tester,
  ) async {
    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Login'), findsNothing);
    expect(find.textContaining('PROFILE'), findsNothing);
    expect(find.textContaining('PRO'), findsNothing);

    await tester.tap(find.text('START GAME'));
    await tester.pumpAndSettle();

    expect(find.text('Comida'), findsOneWidget);
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

    expect(find.text('TOP SECRET'), findsOneWidget);
    expect(find.text('Ana\'s turn'), findsOneWidget);
    expect(find.textContaining('Login'), findsNothing);
  });
}
