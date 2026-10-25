import 'package:outoftheloop/src/features/premium/premium_access.dart';
import 'package:outoftheloop/src/data/purchases/purchase_gateway.dart';
import 'premium_access_test.dart' show BillingFake;
import 'package:outoftheloop/src/data/review/store_review_gateway.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:outoftheloop/src/data/analytics/classic_analytics.dart';
import 'package:outoftheloop/src/data/classic/classic_content_repository.dart';
import 'package:outoftheloop/src/data/classic/classic_session_repository.dart';
import 'package:outoftheloop/src/domain/classic/classic_models.dart';
import 'package:outoftheloop/src/features/classic/application/classic_controller.dart';
import 'package:outoftheloop/src/features/classic/application/classic_experience.dart';

class ReviewFake implements StoreReviewGateway {
  int requests = 0;
  @override
  Future<void> requestReview() async {
    requests++;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late List<String> events;
  late List<Map<String, Object>> parameters;
  late ClassicAnalytics analytics;
  setUp(() {
    events = [];
    parameters = [];
    analytics = ClassicAnalytics(
      sink: (name, values) async {
        events.add(name);
        parameters.add(values);
      },
    );
  });
  ClassicController controller({ClassicSessionRepository? repository}) =>
      ClassicController(
        content: const ClassicContentRepository(),
        repository: repository,
        analytics: analytics,
        config: ClassicConfig(
          players: const [
            ClassicPlayer(id: '1', name: 'PRIVATE NAME'),
            ClassicPlayer(id: '2', name: 'B'),
            ClassicPlayer(id: '3', name: 'C'),
          ],
          categoryIds: {'food'},
        ),
      );
  test(
    'durable start is emitted once; lifecycle/flush do not duplicate it or leak content',
    () async {
      String? saved;
      final c = controller(
        repository: ClassicSessionRepository(
          read: (_) async => saved,
          write: (_, value) async {
            saved = value;
          },
        ),
      );
      addTearDown(c.dispose);
      expect(c.start(), true);
      expect(c.start(), false);
      await c.flush();
      c.setForeground(false);
      c.setForeground(true);
      await c.flush();
      expect(events.where((e) => e == 'classic_round_started'), hasLength(1));
      expect(events.where((e) => e == 'classic_round_saved'), hasLength(1));
      expect(events, isNot(contains('classic_round_unsaved')));
      expect(parameters.every((p) => p.isEmpty), true);
      expect('$events$parameters', isNot(contains('PRIVATE NAME')));
      expect('$events$parameters', isNot(contains(c.round!.word.text)));
    },
  );
  test(
    'write failure and explicit unsaved continuation are distinct and deduplicated',
    () async {
      final c = controller(
        repository: ClassicSessionRepository(
          read: (_) async => null,
          write: (_, _) async => throw StateError('PRIVATE WORD'),
        ),
      );
      addTearDown(c.dispose);
      c.start();
      await c.flush();
      c.continueWithoutSave();
      c.continueWithoutSave();
      await c.flush();
      expect(
        events.where((e) => e == 'classic_persistence_failed'),
        hasLength(1),
      );
      expect(events.where((e) => e == 'classic_round_unsaved'), hasLength(1));
      expect(events, isNot(contains('classic_round_saved')));
      expect('$events$parameters', isNot(contains('PRIVATE WORD')));
    },
  );
  test(
    'share cancellation never logs completion; clipboard fallback is a separate outcome',
    () async {
      final e = ClassicExperience(persist: false, analytics: analytics);
      addTearDown(e.dispose);
      const url = 'https://apps.apple.com/us/app/example/id123456789';
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(
        ClassicExperience.channel,
        (_) async => 'cancelled',
      );
      addTearDown(
        () =>
            messenger.setMockMethodCallHandler(ClassicExperience.channel, null),
      );
      expect(await e.share(url: url), ClassicActionResult.cancelled);
      expect(events, ['classic_share_requested', 'classic_share_cancelled']);
      events.clear();
      messenger.setMockMethodCallHandler(
        ClassicExperience.channel,
        (_) async => throw MissingPluginException(),
      );
      messenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (_) async => null,
      );
      addTearDown(
        () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
      );
      expect(await e.share(url: url), ClassicActionResult.copied);
      expect(events, ['classic_share_requested', 'classic_share_copied']);
      expect(parameters.every((p) => p.isEmpty), true);
    },
  );
  test(
    'opening feedback is never recorded as sent and failed actions stay retryable',
    () async {
      Uri? opened;
      final e = ClassicExperience(
        persist: false,
        analytics: analytics,
        launch: (uri) async {
          opened = uri;
          return true;
        },
      );
      addTearDown(e.dispose);
      expect(
        await e.feedback(email: 'support@example.com'),
        ClassicActionResult.opened,
      );
      expect(opened!.scheme, 'mailto');
      expect(opened!.query, isEmpty);
      expect(events, ['classic_feedback_opened']);
      expect(await e.feedback(email: ''), ClassicActionResult.unavailable);
    },
  );
  test('preferences survive restart with compatible keys', () async {
    SharedPreferences.setMockInitialValues({});
    final e = ClassicExperience();
    await e.load();
    expect(await e.change('settings.language', 'ar'), true);
    expect(await e.change('settings.haptics', false), true);
    expect(await e.change('settings.soundEffects', false), true);
    e.dispose();
    final restored = ClassicExperience();
    await restored.load();
    addTearDown(restored.dispose);
    expect(restored.locale!.languageCode, 'ar');
    expect(restored.hapticsEnabled, false);
    expect(restored.soundEnabled, false);
  });
  test(
    'review records only a request, with no rating or completion claim',
    () async {
      final review = ReviewFake();
      final e = ClassicExperience(
        persist: false,
        analytics: analytics,
        reviewGateway: review,
      );
      addTearDown(e.dispose);
      expect(await e.review(), ClassicActionResult.opened);
      expect(review.requests, 1);
      expect(events, ['classic_review_requested']);
    },
  );
  test(
    'audio and haptics off prevent tap feedback without blocking actions',
    () async {
      final e = ClassicExperience(persist: false);
      addTearDown(e.dispose);
      final platformCalls = <String>[];
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
        platformCalls.add(call.method);
        return null;
      });
      addTearDown(
        () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
      );
      await e.change('settings.soundEffects', false);
      await e.change('settings.haptics', false);
      await e.change('settings.music', false);
      e.tap();
      expect(platformCalls, isNot(contains('HapticFeedback.vibrate')));
      expect(e.effects.soundEffectsEnabled, false);
      expect(e.music.musicEnabled, false);
    },
  );
  test(
    'Premium funnel uses only enumerated origin/plan and verified rights',
    () async {
      final gateway = BillingFake()
        ..value = const PurchaseSnapshot(
          offers: {
            'private-store-id': PackOffer(
              id: 'private-store-id',
              price: 'PRIVATE PRICE',
              currencyCode: 'USD',
              amount: 10,
              period: 'P1Y',
            ),
          },
        );
      final access = PremiumAccess(
        gateway: gateway,
        entitlement: 'private-entitlement',
        analytics: analytics,
      )..origin = ClassicOrigin.categories;
      addTearDown(access.dispose);
      await access.refresh();
      gateway.outcome = PurchaseOutcome.cancelled;
      await access.buy('private-store-id');
      expect(events, [
        'classic_plan_selected',
        'classic_purchase_requested',
        'classic_purchase_cancelled',
      ]);
      expect(
        parameters,
        everyElement({'origin': 'categories', 'plan': 'annual'}),
      );
      gateway.value = const PurchaseSnapshot();
      await access.refresh(restore: true);
      expect(events.last, 'classic_restore_empty');
      expect('$events$parameters', isNot(contains('private-store-id')));
      expect('$events$parameters', isNot(contains('PRIVATE PRICE')));
    },
  );
  test('telemetry failures cannot break gameplay', () {
    final c = controller();
    addTearDown(c.dispose);
    ClassicAnalytics(
      sink: (_, _) async => throw StateError('private'),
    ).record(ClassicEvent.roundStarted);
    expect(c.start(), true);
  });
}
