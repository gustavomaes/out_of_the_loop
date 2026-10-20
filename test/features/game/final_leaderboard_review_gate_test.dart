import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/review/app_review_store.dart';
import 'package:outoftheloop/src/data/review/store_review_gateway.dart';
import 'package:outoftheloop/src/domain/services/app_review_prompt.dart';
import 'package:outoftheloop/src/features/game/final_leaderboard_review_gate.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('asks on the leaderboard and waits after a decline', (
    tester,
  ) async {
    final store = _MemoryReviewStore();
    final gateway = _FakeReviewGateway();
    final now = DateTime.utc(2026, 10, 19);
    final prompt = AppReviewPrompt(
      store: store,
      gateway: gateway,
      now: () => now,
    );

    await tester.pumpWidget(
      _TestApp(
        child: FinalLeaderboardReviewGate(
          reviewPrompt: prompt,
          delay: const Duration(milliseconds: 1500),
          child: const Text('leaderboard'),
        ),
      ),
    );

    expect(find.text('RATE THE APP'), findsNothing);

    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump();

    expect(find.text('Enjoyed the match?'), findsOneWidget);
    expect(find.text('NOT NOW'), findsOneWidget);

    await tester.tap(find.text('NOT NOW'));
    await tester.pumpAndSettle();

    expect(store.declinedAtValue, now);
    expect(gateway.calls, 0);
    expect(find.text('Enjoyed the match?'), findsNothing);

    await tester.pumpWidget(
      _TestApp(
        child: FinalLeaderboardReviewGate(
          reviewPrompt: prompt,
          delay: const Duration(milliseconds: 1500),
          child: const Text('leaderboard'),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump();

    expect(find.text('Enjoyed the match?'), findsNothing);
  });

  testWidgets('opens the store review when the player agrees', (tester) async {
    final store = _MemoryReviewStore();
    final gateway = _FakeReviewGateway();
    final prompt = AppReviewPrompt(
      store: store,
      gateway: gateway,
      now: () => DateTime.utc(2026, 10, 19),
    );

    await tester.pumpWidget(
      _TestApp(
        child: FinalLeaderboardReviewGate(
          reviewPrompt: prompt,
          delay: const Duration(milliseconds: 1500),
          child: const Text('leaderboard'),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump();

    await tester.tap(find.text('RATE THE APP'));
    await tester.pumpAndSettle();

    expect(gateway.calls, 1);
    expect(store.rated, isTrue);
    expect(await prompt.shouldAsk(), isFalse);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    );
  }
}

final class _MemoryReviewStore implements AppReviewStore {
  bool rated = false;
  DateTime? declinedAtValue;

  @override
  Future<DateTime?> declinedAt() async => declinedAtValue;

  @override
  Future<bool> hasRated() async => rated;

  @override
  Future<void> markDeclined(DateTime at) async {
    declinedAtValue = at;
  }

  @override
  Future<void> markRated() async {
    rated = true;
  }
}

final class _FakeReviewGateway implements StoreReviewGateway {
  int calls = 0;

  @override
  Future<void> requestReview() async {
    calls += 1;
  }
}
