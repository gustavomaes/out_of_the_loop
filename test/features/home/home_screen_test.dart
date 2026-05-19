import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/features/home/home_screen.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  testWidgets('renders title and primary home actions', (tester) async {
    var started = false;
    var openedRules = false;

    await tester.pumpWidget(
      _TestApp(
        child: HomeScreen(
          onStartGame: () => started = true,
          onHowToPlay: () => openedRules = true,
        ),
      ),
    );

    expect(find.text('OUT OF THE LOOP'), findsWidgets);
    expect(find.text('START GAME'), findsOneWidget);
    expect(find.text('HOW TO PLAY'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('START GAME'));
    await tester.pump();
    await tester.tap(find.text('HOW TO PLAY'));
    await tester.pump();

    expect(started, isTrue);
    expect(openedRules, isTrue);
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
