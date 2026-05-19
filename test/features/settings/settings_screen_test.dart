import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/features/settings/settings_screen.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  testWidgets('renders language options and timer controls', (tester) async {
    SupportedLanguage? selectedLanguage;
    TimerSettings? selectedTimer;

    await tester.pumpWidget(
      _TestApp(
        child: SettingsScreen(
          onLanguageChanged: (language) => selectedLanguage = language,
          onTimerChanged: (timer) => selectedTimer = timer,
        ),
      ),
    );

    expect(find.text('Portuguese (Brazil)'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Spanish'), findsOneWidget);
    expect(find.text('Hindi'), findsOneWidget);
    expect(find.text('Use timer'), findsOneWidget);

    await tester.tap(find.text('English'));
    await tester.pump();
    await tester.drag(find.byType(ListView), const Offset(0, -180));
    await tester.pump();
    await tester.tap(find.text('Use timer'));
    await tester.pump();

    await tester.scrollUntilVisible(find.textContaining('out of scope'), 200);
    expect(find.textContaining('out of scope'), findsOneWidget);

    expect(selectedLanguage, SupportedLanguage.en);
    expect(selectedTimer?.enabled, isFalse);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: OutOfTheLoopTheme.dark, home: child);
  }
}
