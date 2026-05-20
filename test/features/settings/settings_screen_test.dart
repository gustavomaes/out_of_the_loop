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

    expect(find.text('CONFIGURAÇÕES'), findsOneWidget);
    expect(find.text('IDIOMA'), findsOneWidget);
    expect(find.text('ÁUDIO'), findsOneWidget);
    expect(find.text('Português'), findsOneWidget);
    expect(find.text('Música'), findsOneWidget);
    expect(find.text('Efeitos Sonoros'), findsOneWidget);

    await tester.tap(find.text('Português'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(selectedLanguage, SupportedLanguage.en);
    expect(find.text('English'), findsOneWidget);

    await tester.tap(find.text('Música'));
    await tester.pump();
    expect(musicEnabled, isTrue);

    await tester.tap(find.text('Efeitos Sonoros'));
    await tester.pump();
    expect(soundEffectsEnabled, isFalse);

    await tester.scrollUntilVisible(find.text('SOBRE'), 200);
    expect(find.text('SOBRE'), findsOneWidget);
    expect(find.text('Termos de Uso'), findsOneWidget);
    expect(find.text('Privacidade'), findsOneWidget);
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
