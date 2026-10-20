import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/review/app_review_store.dart';
import 'package:outoftheloop/src/data/review/store_review_gateway.dart';
import 'package:outoftheloop/src/domain/services/app_review_prompt.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppReviewPrompt', () {
    late _MemoryReviewStore store;
    late _FakeReviewGateway gateway;
    late DateTime now;

    setUp(() {
      store = _MemoryReviewStore();
      gateway = _FakeReviewGateway();
      now = DateTime.utc(2026, 10, 19);
    });

    AppReviewPrompt prompt() {
      return AppReviewPrompt(
        store: store,
        gateway: gateway,
        now: () => now,
      );
    }

    test('asks on the first completed match', () async {
      expect(await prompt().shouldAsk(), isTrue);
    });

    test('waits out the cooldown after a decline', () async {
      final reviewPrompt = prompt();
      await reviewPrompt.recordChoice(ReviewPromptChoice.later);

      expect(await reviewPrompt.shouldAsk(), isFalse);

      now = now.add(AppReviewPrompt.declineCooldown - const Duration(seconds: 1));
      expect(await reviewPrompt.shouldAsk(), isFalse);

      now = DateTime.utc(2026, 10, 19).add(AppReviewPrompt.declineCooldown);
      expect(await reviewPrompt.shouldAsk(), isTrue);
    });

    test('stops asking after the player agrees to rate', () async {
      final reviewPrompt = prompt();
      await reviewPrompt.recordChoice(ReviewPromptChoice.rate);

      expect(gateway.calls, 1);
      expect(await reviewPrompt.shouldAsk(), isFalse);

      now = now.add(const Duration(days: 90));
      expect(await reviewPrompt.shouldAsk(), isFalse);
    });

    test('keeps the rated choice when the store sheet fails', () async {
      gateway.error = Exception('store unavailable');
      final reviewPrompt = prompt();

      await reviewPrompt.recordChoice(ReviewPromptChoice.rate);

      expect(store.rated, isTrue);
      expect(await reviewPrompt.shouldAsk(), isFalse);
    });
  });

  group('SharedPreferencesAppReviewStore', () {
    test('persists a decline and a later rating', () async {
      SharedPreferences.setMockInitialValues({});
      const store = SharedPreferencesAppReviewStore();
      final declinedAt = DateTime.utc(2026, 10, 1, 15, 30);

      expect(await store.hasRated(), isFalse);
      expect(await store.declinedAt(), isNull);

      await store.markDeclined(declinedAt);
      expect(await store.declinedAt(), declinedAt);

      await store.markRated();
      expect(await store.hasRated(), isTrue);
    });
  });
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
  Object? error;

  @override
  Future<void> requestReview() async {
    calls += 1;
    final failure = error;
    if (failure != null) {
      throw failure;
    }
  }
}
