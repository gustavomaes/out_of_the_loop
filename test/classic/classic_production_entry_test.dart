import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:outoftheloop/main.dart' as production;
import 'package:outoftheloop/src/features/classic/presentation/classic_app.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_home.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_session_host.dart';

void main() {
  testWidgets('production cold launch opens Classic without onboarding', (
    t,
  ) async {
    SharedPreferences.setMockInitialValues({
      'onboarding.completed': false,
      'settings.language': 'en',
    });
    await production.main();
    await t.pumpAndSettle();
    expect(find.byType(ClassicApp), findsOneWidget);
    expect(find.byType(ClassicSessionHost), findsOneWidget);
    expect(find.byType(ClassicHome), findsOneWidget);
    expect(find.text('Start game'), findsOneWidget);
    expect(Navigator.of(t.element(find.byType(ClassicHome))).canPop(), isFalse);
    await t.tap(find.text('Start game'));
    await t.pumpAndSettle();
    expect(find.byKey(const Key('accessible-reveal')), findsOneWidget);
    expect(find.text('Next player'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });
}
