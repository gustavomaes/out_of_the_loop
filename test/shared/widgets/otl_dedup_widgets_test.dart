import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/shared/widgets/shared_widgets.dart';
import 'package:outoftheloop/src/theme/theme.dart';

void main() {
  testWidgets('OtlShadowedText renders foreground and shadow', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OtlShadowedText(
            text: 'VOTE',
            style: TextStyle(fontSize: 24, color: Colors.white),
            shadowOffset: Offset(4, 4),
          ),
        ),
      ),
    );

    expect(find.text('VOTE'), findsNWidgets(2));
  });

  testWidgets('OtlBrutalistToggle renders', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: OtlBrutalistToggle(value: true)),
      ),
    );

    expect(find.byType(OtlBrutalistToggle), findsOneWidget);
  });

  testWidgets('OtlTimerExpiredMessage renders both lines', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OtlTimerExpiredMessage(
            line1: 'Time is up',
            line2: 'Keep playing',
            style: OtlTimerExpiredMessageStyle.questionRound,
          ),
        ),
      ),
    );

    expect(find.text('Time is up'), findsOneWidget);
    expect(find.text('Keep playing'), findsOneWidget);
  });

  testWidgets('OtlPartyAtmosphere variants build without overflow', (
    tester,
  ) async {
    for (final atmosphere in const [
      OtlPartyAtmosphere.voting(),
      OtlPartyAtmosphere.questionRound(),
      OtlPartyAtmosphere.secretReveal(),
      OtlPartyAtmosphere.matchSetup(),
    ]) {
      await tester.pumpWidget(
        MaterialApp(
          theme: OutOfTheLoopTheme.dark,
          home: Scaffold(body: atmosphere),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    }
  });
}
