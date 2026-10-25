import 'package:flutter/foundation.dart';
import '../../../data/analytics/classic_analytics.dart';
import '../../../data/classic/classic_session_repository.dart';
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
    this.repository,
    ClassicAnalytics? analytics,
    this.categoryAllowed,
    ClassicSession? restored,
  }) : analytics = analytics ?? ClassicAnalytics(),
       _config = config,
       factory = factory ?? ClassicRoundFactory(),
       _history = history ?? ClassicHistory() {
    final watch = Stopwatch()..start();
    _now = now ?? (() => watch.elapsed);
    if (restored != null) {
      _config = restored.config;
      _history = restored.history;
      _round = restored.round;
      if (restored.round != null) _savedStarts.add(restored.round!.id);
      _phase = restored.phase;
      _index = restored.index;
      _remaining = restored.remaining;
      _sequence = restored.revision;
      _revision = restored.revision;
      _preferences = restored.preferences;
      _catalogVersion = restored.catalogVersion;
    }
  }
  final ClassicAnalytics analytics;
  final Set<String> _savedStarts = {};
  final Set<String> _unsavedStarts = {};
  final ClassicSessionRepository? repository;
  int _revision = 0;
  int _pending = 0;
  bool _disposed = false;
  bool persistenceError = false;
  bool continuingWithoutSave = false;
  bool get saving => _pending > 0;
  bool get blocked => saving || (persistenceError && !continuingWithoutSave);
  Map<String, Object> _preferences = const {};
  String _catalogVersion = ClassicContentRepository.catalog.version;
  ClassicSession get session => ClassicSession(
    config: config,
    history: history,
    round: round,
    phase: phase,
    index: revealIndex,
    remaining: remaining,
    revision: _revision,
    preferences: _preferences,
    catalogVersion: _catalogVersion,
  );
  Future<void> flush() async {
    if (repository == null || phase == ClassicPhase.preparing) return;
    _revision++;
    final snapshot = session;
    _pending++;
    try {
      await repository!.save(snapshot);
      if (snapshot.round != null && _savedStarts.add(snapshot.round!.id)) {
        analytics.record(ClassicEvent.roundSaved);
      }
      persistenceError = false;
      continuingWithoutSave = false;
    } on Object {
      if (!persistenceError) analytics.record(ClassicEvent.persistenceFailed);
      persistenceError = true;
      // Pause in memory without triggering another write after a failure.
      _remaining = remaining;
      _runningSince = null;
    } finally {
      _pending--;
      if (!_disposed) super.notifyListeners();
    }
  }

  void continueWithoutSave() {
    if (!persistenceError || continuingWithoutSave) return;
    continuingWithoutSave = true;
    final id = round?.id;
    if (id != null && _unsavedStarts.add(id)) {
      analytics.record(ClassicEvent.roundUnsaved);
    }
    super.notifyListeners();
  }

  void resetHistory() {
    if (blocked || phase != ClassicPhase.home) return;
    _history = ClassicHistory();
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (repository != null && phase != ClassicPhase.preparing) {
      // flush captures the envelope synchronously before its first await.
      flush();
    }
    super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
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
    if (blocked ||
        phase != ClassicPhase.home ||
        !candidate.isValid ||
        candidate.categoryIds.any(
          (id) => !classicCategories.any((c) => c.id == id),
        ) ||
        candidate.contentLanguage != 'en') {
      return false;
    }
    final changes = <ClassicOption>[
      if (!listEquals(_config.players, candidate.players))
        ClassicOption.players,
      if (!setEquals(_config.categoryIds, candidate.categoryIds))
        ClassicOption.categories,
      if (_config.manualImpostors != candidate.manualImpostors)
        ClassicOption.impostors,
      if (_config.hint != candidate.hint) ClassicOption.hint,
      if (_config.timerMinutes != candidate.timerMinutes) ClassicOption.timer,
      if (_config.troll != candidate.troll) ClassicOption.troll,
    ];
    _config = candidate;
    for (final option in changes) {
      analytics.record(ClassicEvent.setupOptionChanged, option: option);
    }
    notifyListeners();
    return true;
  }

  final bool Function(String)? categoryAllowed;
  bool accessAdjusted = false;
  bool start() => _create(ClassicPhase.home);
  bool playAgain() => _create(ClassicPhase.result);
  bool _create(ClassicPhase expected) {
    if (blocked || phase != expected || !_foreground) return false;
    accessAdjusted = false;
    if (categoryAllowed != null) {
      final valid = config.categoryIds.where(categoryAllowed!).toSet();
      if (valid.length != config.categoryIds.length) {
        _config = config.copyWith(
          categoryIds: valid.isEmpty ? {'food', 'animals', 'sports'} : valid,
        );
        accessAdjusted = true;
        notifyListeners();
        return false;
      }
    }
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
      _catalogVersion = ClassicContentRepository.catalog.version;
      _round = created.round;
      _history = created.history;
      _index = 0;
      _viewed = false;
      _remaining = config.timerMinutes == null
          ? null
          : Duration(minutes: config.timerMinutes!);
      _runningSince = null;
      _phase = ClassicPhase.revealing;
      analytics.record(ClassicEvent.roundStarted);
      if (expected == ClassicPhase.result) {
        analytics.record(ClassicEvent.replayStarted);
      }
      if (repository == null) {
        _unsavedStarts.add(_round!.id);
        analytics.record(ClassicEvent.roundUnsaved);
      }
      notifyListeners();
      return true;
    } on StateError {
      _phase = expected;
      notifyListeners();
      return false;
    }
  }

  bool markViewed(int index) {
    if (blocked ||
        !_foreground ||
        phase != ClassicPhase.revealing ||
        index != _index) {
      return false;
    }
    _viewed = true;
    return true;
  }

  bool nextPlayer(int expectedIndex) {
    if (blocked ||
        !_foreground ||
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
      analytics.record(ClassicEvent.discussionStarted);
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
    if (blocked ||
        !_foreground ||
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
      super.notifyListeners();
    }
  }

  bool revealResult() {
    if (blocked || !_foreground || phase != ClassicPhase.discussion) {
      return false;
    }
    _remaining = remaining;
    _runningSince = null;
    _phase = ClassicPhase.result;
    analytics.record(ClassicEvent.roundCompleted);
    notifyListeners();
    return true;
  }

  void endRound() {
    if (round != null) analytics.record(ClassicEvent.roundEnded);
    _round = null;
    _phase = ClassicPhase.home;
    _viewed = false;
    _remaining = null;
    _runningSince = null;
    notifyListeners();
  }
}
