import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/classic/classic_models.dart';
import '../../domain/classic/classic_round_factory.dart';

/// Contains secrets. Never include this envelope in diagnostics or analytics.
class ClassicSession {
  ClassicSession({
    required this.config,
    required this.history,
    this.round,
    this.phase = ClassicPhase.home,
    this.index = 0,
    this.remaining,
    this.revision = 0,
    this.catalogVersion = 'classic-1',
    this.preferences = const {},
  });
  final ClassicConfig config;
  final ClassicHistory history;
  final ClassicRound? round;
  final ClassicPhase phase;
  final int index;
  final Duration? remaining;
  final int revision;
  final String catalogVersion;
  final Map<String, Object> preferences;

  Map<String, dynamic> toJson() => {
    'version': 1,
    'revision': revision,
    'catalogVersion': catalogVersion,
    'config': encodeConfig(config),
    'preferences': preferences,
    'history': {
      'seen': history.seen,
      'categoryRounds': history.categoryRounds,
      'lastImpostors': history.lastImpostors.toList(),
      'lastWord': history.lastWord,
      'rounds': history.rounds,
    },
    'snapshot': round == null
        ? null
        : {
            'phase': phase.name,
            'index': index,
            'remainingMs': remaining?.inMilliseconds,
            'id': round!.id,
            'config': encodeConfig(round!.config),
            'word': {
              'id': round!.word.id,
              'categoryId': round!.word.categoryId,
              'language': round!.word.language,
              'text': round!.word.text,
            },
            'categoryName': round!.categoryName,
            'impostors': round!.impostorIds.toList(),
            'starter': round!.starterId,
            'troll': round!.troll,
          },
  };
  static Map<String, dynamic> encodeConfig(ClassicConfig c) => {
    'players': c.players.map((p) => {'id': p.id, 'name': p.name}).toList(),
    'categories': c.categoryIds.toList(),
    'language': c.contentLanguage,
    'manual': c.manualImpostors,
    'hint': c.hint,
    'timer': c.timerMinutes,
    'troll': c.troll,
  };
  static ClassicConfig decodeConfig(dynamic value) {
    final c = value as Map<String, dynamic>;
    final result = ClassicConfig(
      players: (c['players'] as List)
          .map(
            (p) =>
                ClassicPlayer(id: p['id'] as String, name: p['name'] as String),
          )
          .toList(),
      categoryIds: (c['categories'] as List).cast<String>().toSet(),
      contentLanguage: c['language'] as String,
      manualImpostors: c['manual'] as int?,
      hint: c['hint'] as bool,
      timerMinutes: c['timer'] as int?,
      troll: c['troll'] as bool,
    );
    if (!result.isValid) throw const FormatException('Invalid configuration');
    return result;
  }

  static ClassicHistory decodeHistory(dynamic value) {
    final h = value as Map<String, dynamic>;
    Map<String, int> counts(dynamic v) {
      final values = Map<String, int>.from(v as Map);
      if (values.values.any((n) => n < 0)) throw const FormatException();
      return values;
    }

    final rounds = h['rounds'] as int;
    final seen = counts(h['seen']);
    final categories = counts(h['categoryRounds']);
    if (rounds < 0 ||
        seen.values.any((n) => n > rounds) ||
        categories.values.any((n) => n > rounds)) {
      throw const FormatException();
    }
    return ClassicHistory(
      seen: seen,
      categoryRounds: categories,
      lastImpostors: (h['lastImpostors'] as List).cast<String>().toSet(),
      lastWord: h['lastWord'] as String?,
      rounds: rounds,
    );
  }

  static ClassicSession fromJson(Map<String, dynamic> data) {
    if (data['version'] != 1) throw const FormatException('Unknown schema');
    final config = decodeConfig(data['config']);
    final history = decodeHistory(data['history']);
    final revision = data['revision'] as int;
    final catalog = data['catalogVersion'] as String;
    if (revision < 0 || catalog.isEmpty) throw const FormatException();
    final preferences = Map<String, Object>.from(data['preferences'] as Map);
    final s = data['snapshot'];
    ClassicRound? round;
    var phase = ClassicPhase.home;
    var index = 0;
    Duration? remaining;
    if (s != null) {
      phase = ClassicPhase.values.byName(s['phase'] as String);
      if (![
        ClassicPhase.revealing,
        ClassicPhase.discussion,
        ClassicPhase.result,
      ].contains(phase)) {
        throw const FormatException();
      }
      final frozen = decodeConfig(s['config']);
      final w = s['word'];
      final word = ClassicWord(
        id: w['id'] as String,
        categoryId: w['categoryId'] as String,
        language: w['language'] as String,
        text: w['text'] as String,
      );
      final ids = frozen.players.map((p) => p.id).toSet();
      final impostorList = (s['impostors'] as List).cast<String>();
      final impostors = impostorList.toSet();
      final troll = s['troll'] as bool;
      index = s['index'] as int;
      final ms = s['remainingMs'] as int?;
      if (ms != null) remaining = Duration(milliseconds: ms);
      if (index < 0 ||
          index >= ids.length ||
          (phase != ClassicPhase.revealing && index != ids.length - 1) ||
          !ids.contains(s['starter']) ||
          !ids.containsAll(impostors) ||
          impostors.length != impostorList.length ||
          impostors.length != (troll ? ids.length : frozen.impostors) ||
          (troll && !frozen.troll) ||
          word.id.isEmpty ||
          word.text.trim().isEmpty ||
          !frozen.categoryIds.contains(word.categoryId) ||
          word.language != frozen.contentLanguage ||
          (s['categoryName'] as String).trim().isEmpty ||
          (s['id'] as String).isEmpty ||
          (ms == null) != (frozen.timerMinutes == null) ||
          (ms != null && (ms < 0 || ms > frozen.timerMinutes! * 60000)) ||
          jsonEncode(encodeConfig(config)) !=
              jsonEncode(encodeConfig(frozen))) {
        throw const FormatException('Inconsistent snapshot');
      }
      round = ClassicRound(
        id: s['id'] as String,
        config: frozen,
        word: word,
        categoryName: s['categoryName'] as String,
        impostorIds: impostors,
        starterId: s['starter'] as String,
        troll: troll,
      );
    }
    return ClassicSession(
      config: config,
      history: history,
      round: round,
      phase: phase,
      index: index,
      remaining: remaining,
      revision: revision,
      catalogVersion: catalog,
      preferences: preferences,
    );
  }
}

class ClassicSessionLoad {
  const ClassicSessionLoad(
    this.session, {
    this.issue = false,
    this.future = false,
  });
  final ClassicSession session;
  final bool issue;
  final bool future;
}

/// Serializes complete immutable envelopes at enqueue time, not at completion.
class ClassicSessionRepository {
  ClassicSessionRepository({required this.read, required this.write});
  final Future<String?> Function(String key) read;
  final Future<void> Function(String key, String value) write;
  static const storageKey = 'classic.session.v1';
  Future<void> _tail = Future.value();
  static Future<ClassicSessionRepository> open() async {
    final prefs = await SharedPreferences.getInstance();
    return ClassicSessionRepository(
      read: (key) async {
        await prefs.reload();
        final value = prefs.get(key);
        // A wrong preference type is corruption, not a fatal bootstrap failure.
        return value == null || value is String
            ? value as String?
            : '{invalid-type';
      },
      write: (key, value) async {
        if (!await prefs.setString(key, value)) {
          throw StateError('Session write failed');
        }
      },
    );
  }

  Future<void> save(ClassicSession session) {
    final raw = jsonEncode(session.toJson());
    // Validate our own writes too. A bad transition must not replace a valid save.
    ClassicSession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    final operation = _tail.then((_) async {
      await write(storageKey, raw);
      if (await read(storageKey) != raw) {
        throw StateError('Session verification failed');
      }
    });
    _tail = operation.then<void>((_) {}, onError: (Object _, StackTrace _) {});
    return operation;
  }

  Future<ClassicSessionLoad> load(
    ClassicSession fallback, {
    ClassicSession Function(Map<String, dynamic>)? migrate,
  }) async {
    final raw = await read(storageKey);
    if (raw == null) {
      final legacy = await read('game.session.v1');
      if (legacy == null || migrate == null) {
        return ClassicSessionLoad(fallback);
      }
      var session = fallback;
      try {
        session = migrate(jsonDecode(legacy) as Map<String, dynamic>);
        await save(
          session,
        ); // The validated envelope itself marks migration complete.
        return ClassicSessionLoad(session);
      } on Object {
        return ClassicSessionLoad(session, issue: true);
      }
    }
    Map<String, dynamic>? data;
    try {
      data = jsonDecode(raw) as Map<String, dynamic>;
      if (data['version'] != 1) {
        return ClassicSessionLoad(fallback, issue: true, future: true);
      }
      return ClassicSessionLoad(ClassicSession.fromJson(data));
    } on Object {
      // Recover independent valid fields. Never reinterpret an unknown version.
      var config = fallback.config;
      var history = fallback.history;
      if (data?['version'] == 1) {
        try {
          config = ClassicSession.decodeConfig(data!['config']);
        } on Object {
          /* retain defaults */
        }
        try {
          history = ClassicSession.decodeHistory(data!['history']);
        } on Object {
          /* retain defaults */
        }
      }
      return ClassicSessionLoad(
        ClassicSession(config: config, history: history),
        issue: true,
      );
    }
  }
}
