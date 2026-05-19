import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/shared/widgets/shared_widgets.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  testWidgets('disabled button does not trigger its action', (tester) async {
    var taps = 0;

    await tester.pumpWidget(
      _TestApp(
        child: OtlButton.primary(
          label: 'Start',
          onPressed: null,
          key: const Key('disabled_button'),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('disabled_button')));
    await tester.pump();

    expect(taps, 0);
  });

  testWidgets('button keeps the minimum touch target', (tester) async {
    await tester.pumpWidget(
      _TestApp(
        child: OtlButton.secondary(
          label: 'Go',
          onPressed: () {},
          key: const Key('touch_target_button'),
        ),
      ),
    );

    final size = tester.getSize(find.byKey(const Key('touch_target_button')));

    expect(size.width, greaterThanOrEqualTo(44));
    expect(size.height, greaterThanOrEqualTo(44));
  });

  testWidgets('card, text field, and avatar use tokenized styling', (
    tester,
  ) async {
    await tester.pumpWidget(
      const _TestApp(
        child: Column(
          children: [
            OtlCard(child: Text('Card')),
            OtlTextField(hintText: 'Name'),
            PlayerAvatar(name: 'Ada Lovelace', seed: 'ada'),
          ],
        ),
      ),
    );

    final card = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final avatar = tester.widget<Container>(
      find
          .descendant(
            of: find.byType(PlayerAvatar),
            matching: find.byType(Container),
          )
          .first,
    );

    expect(find.text('AL'), findsOneWidget);
    expect(card.duration, AppDurations.fast);
    expect((avatar.decoration! as BoxDecoration).shape, BoxShape.circle);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: OutOfTheLoopTheme.dark,
      home: Scaffold(body: Center(child: child)),
    );
  }
}
