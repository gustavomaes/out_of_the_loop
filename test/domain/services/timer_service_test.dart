import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/domain/services/timer_service.dart';

void main() {
  group('TimerService', () {
    const service = TimerService();

    test('uses 30 seconds as the default enabled duration', () {
      final state = service.start();

      expect(state.settings, const TimerSettings());
      expect(state.remainingSeconds, 30);
      expect(state.isEnabled, isTrue);
      expect(state.isExpired, isFalse);
    });

    test('supports configured timer duration', () {
      final state = service.start(
        const TimerSettings(enabled: true, durationSeconds: 10),
      );

      final ticked = service.tick(state, seconds: 4);

      expect(ticked.remainingSeconds, 6);
      expect(ticked.progress, 0.6);
    });

    test('can be disabled without counting down', () {
      const settings = TimerSettings(enabled: false, durationSeconds: 20);
      final state = service.start(settings);

      expect(service.tick(state, seconds: 10).remainingSeconds, 20);
      expect(state.isEnabled, isFalse);
      expect(state.progress, 1);
    });

    test('expires without recording a vote or side effect', () {
      final expired = service.expire(service.start());

      expect(expired.remainingSeconds, 0);
      expect(expired.isExpired, isTrue);
    });
  });
}
