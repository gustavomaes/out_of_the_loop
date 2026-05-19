import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/features/home/home_screen.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  testWidgets('renders title and primary home actions', (tester) async {
    late AppLocalizations l10n;
    var started = false;
    var openedRules = false;

    await tester.pumpWidget(
      _TestApp(
        child: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context)!;
            return HomeScreen(
              onStartGame: () => started = true,
              onHowToPlay: () => openedRules = true,
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('OUT OF THE'), findsNWidgets(2));
    expect(find.text('LOOP'), findsNWidgets(2));
    expect(find.text(l10n.startGame), findsOneWidget);
    expect(find.text(l10n.howToPlay), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('A party game of secrets'), findsNothing);

    await tester.tap(find.text(l10n.startGame));
    await tester.pump();
    await tester.tap(find.text(l10n.howToPlay));
    await tester.pump();

    expect(started, isTrue);
    expect(openedRules, isTrue);
  });

  testWidgets('shows english button copy when locale is en', (tester) async {
    await tester.pumpWidget(
      const _TestApp(
        locale: Locale('en'),
        child: HomeScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('START GAME'), findsOneWidget);
    expect(find.text('HOW TO PLAY'), findsOneWidget);
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
