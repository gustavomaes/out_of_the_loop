import '../models/models.dart';

final class TimerState {
  const TimerState({required this.settings, required this.remainingSeconds});

  final TimerSettings settings;
  final int remainingSeconds;

  bool get isEnabled => settings.enabled;
  bool get isExpired => isEnabled && remainingSeconds == 0;

  double get progress {
    if (!isEnabled) {
      return 1;
    }
    return remainingSeconds / settings.durationSeconds;
  }
}

final class TimerService {
  const TimerService();

  static const defaultSettings = TimerSettings();

  TimerState start([TimerSettings settings = defaultSettings]) {
    _validate(settings);
    return TimerState(
      settings: settings,
      remainingSeconds: settings.durationSeconds,
    );
  }

  TimerState tick(TimerState state, {int seconds = 1}) {
    if (!state.isEnabled) {
      return state;
    }
    if (seconds < 0) {
      throw ArgumentError.value(seconds, 'seconds', 'Must not be negative.');
    }
    final remaining = state.remainingSeconds - seconds;
    return TimerState(
      settings: state.settings,
      remainingSeconds: remaining < 0 ? 0 : remaining,
    );
  }

  TimerState expire(TimerState state) {
    return TimerState(settings: state.settings, remainingSeconds: 0);
  }

  void _validate(TimerSettings settings) {
    if (settings.durationSeconds < 1) {
      throw ArgumentError.value(
        settings.durationSeconds,
        'durationSeconds',
        'Must be at least 1.',
      );
    }
  }
}
