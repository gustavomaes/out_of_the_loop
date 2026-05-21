import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/features/settings/settings_screen.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/l10n/out_of_the_loop_localizations.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  testWidgets('renders Figma-aligned settings sections and controls', (
    tester,
  ) async {
    SupportedLanguage? selectedLanguage;
    bool? musicEnabled;
    bool? soundEffectsEnabled;

    await tester.pumpWidget(
      _TestApp(
        child: SettingsScreen(
          onLanguageChanged: (language) => selectedLanguage = language,
          onMusicEnabledChanged: (value) => musicEnabled = value,
          onSoundEffectsEnabledChanged: (value) =>
              soundEffectsEnabled = value,
        ),
      ),
    );

    expect(find.text('SETTINGS'), findsOneWidget);
    expect(find.text('LANGUAGE'), findsOneWidget);
    expect(find.text('AUDIO'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Music'), findsOneWidget);
    expect(find.text('Sound Effects'), findsOneWidget);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Portuguese'));
    await tester.pumpAndSettle();

    expect(selectedLanguage, SupportedLanguage.ptBr);
    expect(find.text('Portuguese'), findsOneWidget);

    await tester.tap(find.text('Music'));
    await tester.pump();
    expect(musicEnabled, isTrue);

    await tester.tap(find.text('Sound Effects'));
    await tester.pump();
    expect(soundEffectsEnabled, isFalse);

    await tester.scrollUntilVisible(find.text('ABOUT'), 200);
    expect(find.text('ABOUT'), findsOneWidget);
    expect(find.text('Terms of Use'), findsOneWidget);
    expect(find.text('Privacy'), findsOneWidget);
    expect(find.text('v0.1.0'), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: OutOfTheLoopTheme.dark,
      locale: OutOfTheLoopLocalizations.fallbackLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: OutOfTheLoopLocalizations.supportedLocales,
      home: child,
    );
  }
}
