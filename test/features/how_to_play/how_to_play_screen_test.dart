import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/features/how_to_play/how_to_play_screen.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  testWidgets('shows rule sections and done action', (tester) async {
    var done = false;

    await tester.pumpWidget(
      _TestApp(child: HowToPlayScreen(onDone: () => done = true)),
    );

    expect(find.text('O SEGREDO'), findsOneWidget);
    expect(find.text('A PERGUNTA'), findsOneWidget);
    expect(find.text('A VOTACAO'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('O DESFECHO'), 200);
    expect(find.text('O DESFECHO'), findsOneWidget);
    expect(find.textContaining('mais da metade'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('ENTENDI'), 200);
    await tester.tap(find.text('ENTENDI'));
    await tester.pump();

    expect(done, isTrue);
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
