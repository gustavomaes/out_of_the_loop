import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/features/how_to_play/how_to_play_screen.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  testWidgets('shows localized rule sections', (tester) async {
    late AppLocalizations l10n;

    await tester.pumpWidget(
      _TestApp(
        locale: const Locale('pt', 'BR'),
        child: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context)!;
            return const HowToPlayScreen();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(l10n.howToPlayScreenTitle), findsOneWidget);
    expect(find.text(l10n.howToPlaySecretTitle), findsOneWidget);
    expect(find.text(l10n.howToPlayQuestionTitle), findsOneWidget);
    expect(find.textContaining(l10n.howToPlaySecretBodyHighlight), findsOneWidget);
    expect(find.textContaining(l10n.howToPlayQuestionBodyEmphasis), findsOneWidget);

    await tester.scrollUntilVisible(
      find.textContaining(l10n.howToPlayVoteBodyHighlight),
      100,
    );
    expect(find.textContaining(l10n.howToPlayVoteBodyHighlight), findsOneWidget);

    await tester.scrollUntilVisible(find.text(l10n.howToPlayOutcomeTitle), 200);
    expect(find.text(l10n.howToPlayOutcomeTitle), findsOneWidget);
    expect(find.textContaining(l10n.howToPlayOutcomeBodyHighlight), findsOneWidget);
    expect(find.text(l10n.howToPlayKapow), findsOneWidget);
  });

  testWidgets('shows english copy when locale is en', (tester) async {
    await tester.pumpWidget(
      const _TestApp(
        locale: Locale('en'),
        child: HowToPlayScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('HOW TO PLAY'), findsOneWidget);
    expect(find.text('THE SECRET'), findsOneWidget);
    expect(find.textContaining('Out of the Loop!'), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child, this.locale = const Locale('pt', 'BR')});

  final Widget child;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: OutOfTheLoopTheme.dark,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    );
  }
}
