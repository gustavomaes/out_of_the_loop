import 'package:flutter/foundation.dart';
import '../../../domain/classic/classic_models.dart';
import '../../../domain/classic/classic_round_factory.dart';
import '../../../data/classic/classic_content_repository.dart';

class ClassicController extends ChangeNotifier {
  ClassicController({
    required this.content,
    required ClassicConfig config,
    ClassicRoundFactory? factory,
    Duration Function()? now,
    ClassicHistory? history,
  }) : _config = config,
       factory = factory ?? ClassicRoundFactory(),
       _history = history ?? ClassicHistory() {
    final watch = Stopwatch()..start();
    _now = now ?? (() => watch.elapsed);
  }
  final ClassicContentRepository content;
  final ClassicRoundFactory factory;
  late final Duration Function() _now;
  ClassicConfig _config;
  ClassicConfig get config => _config;
  ClassicPhase _phase = ClassicPhase.home;
  ClassicPhase get phase => _phase;
  ClassicRound? _round;
  ClassicRound? get round => _round;
  ClassicHistory _history;
  ClassicHistory get history => _history;
  int _index = 0;
  int get revealIndex => _index;
  bool _viewed = false;
  bool get viewed => _viewed;
  bool _foreground = true;
  bool get foreground => _foreground;
  int _sequence = 0;
  Duration? _remaining;
  Duration? _runningSince;
  bool get timerRunning => _runningSince != null && remaining! > Duration.zero;
  Duration? get remaining {
    if (_remaining == null) return null;
    final value =
        _remaining! -
        (_runningSince == null ? Duration.zero : _now() - _runningSince!);
    return value < Duration.zero ? Duration.zero : value;
  }

  bool updateConfig(ClassicConfig candidate) {
    if (phase != ClassicPhase.home ||
        !candidate.isValid ||
        candidate.categoryIds.any(
          (id) => !classicCategories.any((c) => c.id == id),
        ) ||
        candidate.contentLanguage != 'en') {
      return false;
    }
    _config = candidate;
    notifyListeners();
    return true;
  }

  bool start() => _create(ClassicPhase.home);
  bool playAgain() => _create(ClassicPhase.result);
  bool _create(ClassicPhase expected) {
    if (phase != expected || !_foreground) return false;
    _phase = ClassicPhase.preparing;
    notifyListeners();
    try {
      final created = factory.create(
        id: 'classic-${++_sequence}',
        config: config,
        words: content.wordsFor(config),
        categoryNames: {for (final c in classicCategories) c.id: c.name},
        history: _history,
      );
      _round = created.round;
      _history = created.history;
      _index = 0;
      _viewed = false;
      _remaining = config.timerMinutes == null
          ? null
          : Duration(minutes: config.timerMinutes!);
      _runningSince = null;
      _phase = ClassicPhase.revealing;
      notifyListeners();
      return true;
    } on StateError {
      _phase = expected;
      notifyListeners();
      return false;
    }
  }

  bool markViewed(int index) {
    if (!_foreground || phase != ClassicPhase.revealing || index != _index) {
      return false;
    }
    _viewed = true;
    return true;
  }

  bool nextPlayer(int expectedIndex) {
    if (!_foreground ||
        phase != ClassicPhase.revealing ||
        !_viewed ||
        expectedIndex != _index) {
      return false;
    }
    _viewed = false;
    if (_index + 1 < round!.config.players.length) {
      _index++;
    } else {
      _phase = ClassicPhase.discussion;
      if (_remaining != null) _runningSince = _now();
    }
    notifyListeners();
    return true;
  }

  void pauseTimer() {
    _remaining = remaining;
    _runningSince = null;
    notifyListeners();
  }

  void resumeTimer() {
    if (!_foreground ||
        phase != ClassicPhase.discussion ||
        timerRunning ||
        remaining == null ||
        remaining == Duration.zero) {
      return;
    }
    _runningSince = _now();
    notifyListeners();
  }

  void setForeground(bool value) {
    _foreground = value;
    if (!value) {
      // A role interrupted while open must be viewed again. Conservatively
      // require a new viewing even if it was already covered before interruption.
      _viewed = false;
      pauseTimer();
    } else {
      notifyListeners();
    }
  }

  bool revealResult() {
    if (!_foreground || phase != ClassicPhase.discussion) return false;
    _remaining = remaining;
    _runningSince = null;
    _phase = ClassicPhase.result;
    notifyListeners();
    return true;
  }

  void endRound() {
    _round = null;
    _phase = ClassicPhase.home;
    _viewed = false;
    _remaining = null;
    _runningSince = null;
    notifyListeners();
  }
}
