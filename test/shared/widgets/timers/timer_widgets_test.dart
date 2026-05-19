import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/shared/widgets/timers/timers.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  testWidgets('circular timer renders countdown display and progress', (
    tester,
  ) async {
    await tester.pumpWidget(
      const _TestApp(
        child: CircularTimer(remainingSeconds: 20, totalSeconds: 30),
      ),
    );

    final indicator = tester.widget<CircularProgressIndicator>(
      find.byKey(const Key('otl_circular_timer_indicator')),
    );

    expect(find.text('20'), findsOneWidget);
    expect(indicator.value, closeTo(2 / 3, 0.001));
    expect(indicator.color, AppColors.primaryMain);
  });

  testWidgets('progress timer renders proportional progress', (tester) async {
    await tester.pumpWidget(
      const _TestApp(
        child: ProgressTimer(remainingSeconds: 15, totalSeconds: 30),
      ),
    );

    final indicator = tester.widget<LinearProgressIndicator>(
      find.byKey(const Key('otl_progress_timer_indicator')),
    );

    expect(indicator.value, 0.5);
    expect(indicator.color, AppColors.primaryMain);
  });

  testWidgets('timers enter warning state in final five seconds', (
    tester,
  ) async {
    await tester.pumpWidget(
      const _TestApp(
        child: Column(
          children: [
            CircularTimer(remainingSeconds: 5, totalSeconds: 30),
            ProgressTimer(remainingSeconds: 4, totalSeconds: 30),
          ],
        ),
      ),
    );

    final circular = tester.widget<CircularProgressIndicator>(
      find.byKey(const Key('otl_circular_timer_indicator')),
    );
    final progress = tester.widget<LinearProgressIndicator>(
      find.byKey(const Key('otl_progress_timer_indicator')),
    );

    expect(circular.color, AppColors.error);
    expect(progress.color, AppColors.error);
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
