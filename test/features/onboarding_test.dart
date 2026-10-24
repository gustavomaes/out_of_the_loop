import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/out_of_the_loop_app.dart';
import 'package:outoftheloop/src/features/onboarding/onboarding_screen.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<void> launch(WidgetTester tester, {bool completed = false}) async {
    SharedPreferences.setMockInitialValues({
      'settings.language': 'en',
      'onboarding.completed': completed,
    });
    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();
  }

  Future<void> tap(WidgetTester tester, String text) async {
    await tester.tap(find.text(text));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'first launch teaches all steps, practices reveal, and persists completion',
    (tester) async {
      await launch(tester);
      expect(find.text('STEP 1 OF 3'), findsOneWidget);
      expect(find.text('Pizza'), findsNWidgets(2));
      await tap(tester, 'Continue');
      expect(find.text('STEP 2 OF 3'), findsOneWidget);
      expect(find.text('Pizza'), findsNothing);
      await tester.tap(find.byKey(const Key('onboarding-demo')));
      await tester.pump();
      expect(find.text('Pizza'), findsOneWidget);
      await tester.tap(find.byKey(const Key('onboarding-demo')));
      await tester.pump();
      expect(find.text('Pizza'), findsNothing);
      await tap(tester, 'Continue');
      expect(find.text('STEP 3 OF 3'), findsOneWidget);
      await tester.tap(find.text('Start a game'));
      for (var attempt = 0; attempt < 50; attempt++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump(const Duration(milliseconds: 100));
        if (find.text('Food & Drink').evaluate().isNotEmpty) break;
      }
      expect(find.text('Food & Drink'), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(OnboardingScreen), findsNothing);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('onboarding.completed'), isTrue);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      await tester.pumpWidget(const OutOfTheLoopApp());
      await tester.pumpAndSettle();
      expect(find.byType(OnboardingScreen), findsNothing);
      expect(find.text('START GAME'), findsOneWidget);
    },
  );

  testWidgets('skip on every step persists and returns home', (tester) async {
    for (var step = 0; step < 3; step++) {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      await launch(tester);
      for (var i = 0; i < step; i++) {
        await tap(tester, 'Continue');
      }
      await tap(tester, 'Skip');
      expect(find.text('START GAME'), findsOneWidget);
      expect(
        (await SharedPreferences.getInstance()).getBool('onboarding.completed'),
        isTrue,
      );
    }
  });

  testWidgets('replay supports back between steps and skip returns to Play', (
    tester,
  ) async {
    await launch(tester, completed: true);
    await tap(tester, 'HOW TO PLAY');
    await tap(tester, 'Replay interactive tutorial');
    expect(find.text('STEP 1 OF 3'), findsOneWidget);
    await tap(tester, 'Continue');
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('STEP 1 OF 3'), findsOneWidget);
    await tap(tester, 'Skip');
    expect(find.text('START GAME'), findsOneWidget);
    expect(find.text('Replay interactive tutorial'), findsNothing);
    expect(find.byType(OnboardingScreen), findsNothing);
  });

  testWidgets('interrupted tutorial remains eligible on next launch', (
    tester,
  ) async {
    await launch(tester);
    await tap(tester, 'Continue');
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    await tester.pumpWidget(const OutOfTheLoopApp());
    await tester.pumpAndSettle();
    expect(find.text('STEP 1 OF 3'), findsOneWidget);
  });

  testWidgets('save failure allows retry without trapping the user', (
    tester,
  ) async {
    var attempts = 0;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        theme: OutOfTheLoopTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OnboardingScreen(
          onComplete: (_) async {
            attempts++;
            if (attempts == 1) throw StateError('storage unavailable');
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tap(tester, 'Skip');
    expect(find.text('Could not save. Please try again.'), findsOneWidget);
    await tap(tester, 'Skip');
    expect(attempts, 2);
  });

  for (final locale in [
    const Locale('pt', 'BR'),
    const Locale('en'),
    const Locale('es'),
    const Locale('hi'),
    const Locale('ar'),
  ]) {
    testWidgets('all steps fit compact screens with large text in $locale', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          theme: OutOfTheLoopTheme.dark,
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(2)),
            child: child!,
          ),
          home: OnboardingScreen(onComplete: (_) async {}),
        ),
      );
      await tester.pumpAndSettle();
      for (var step = 0; step < 3; step++) {
        expect(tester.takeException(), isNull);
        if (step < 2) {
          final context = tester.element(find.byType(OnboardingScreen));
          await tap(tester, AppLocalizations.of(context)!.onboardingNext);
        }
      }
    });
  }
}
