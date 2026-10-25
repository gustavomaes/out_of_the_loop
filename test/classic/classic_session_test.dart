import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/classic/classic_session_repository.dart';
import 'package:outoftheloop/src/data/classic/classic_content_repository.dart';
import 'package:outoftheloop/src/data/classic/classic_legacy_migration.dart';
import 'package:outoftheloop/src/domain/classic/classic_models.dart';
import 'package:outoftheloop/src/domain/classic/classic_round_factory.dart';
import 'package:outoftheloop/src/features/classic/application/classic_controller.dart';

ClassicConfig config() => ClassicConfig(
  players: const [
    ClassicPlayer(id: 'a', name: 'Alex'),
    ClassicPlayer(id: 'b', name: 'Sam'),
    ClassicPlayer(id: 'c', name: 'Robin'),
  ],
  categoryIds: {'food'},
  timerMinutes: 3,
);
ClassicSession fallback() =>
    ClassicSession(config: config(), history: ClassicHistory());
void main() {
  late Map<String, String> storage;
  late ClassicSessionRepository repo;
  setUp(() {
    storage = {};
    repo = ClassicSessionRepository(
      read: (key) async => storage[key],
      write: (key, value) async {
        storage[key] = value;
      },
    );
  });
  test(
    'every confirmed phase restores frozen round, covered and paused',
    () async {
      var clock = Duration.zero;
      final c = ClassicController(
        content: const ClassicContentRepository(),
        config: config(),
        repository: repo,
        now: () => clock,
      );
      addTearDown(c.dispose);
      expect(c.start(), true);
      expect(c.start(), false);
      await c.flush();
      final firstId = c.round!.id;
      Future<ClassicController> restart() async {
        final saved = await repo.load(fallback());
        expect(saved.issue, false);
        final restored = ClassicController(
          content: const ClassicContentRepository(),
          config: config(),
          restored: saved.session,
          repository: repo,
        );
        expect(restored.round!.id, firstId);
        expect(restored.round!.word.text, c.round!.word.text);
        expect(restored.round!.impostorIds, c.round!.impostorIds);
        expect(restored.round!.starterId, c.round!.starterId);
        expect(restored.viewed, false);
        expect(restored.timerRunning, false);
        expect(restored.phase, c.phase);
        expect(restored.revealIndex, c.revealIndex);
        addTearDown(restored.dispose);
        return restored;
      }

      await restart();
      for (var i = 0; i < 3; i++) {
        expect(c.markViewed(i), true);
        expect(c.nextPlayer(i), true);
        await c.flush();
        await restart();
      }
      clock = const Duration(seconds: 23);
      c.setForeground(false);
      await c.flush();
      final paused = await restart();
      expect(paused.remaining, const Duration(seconds: 157));
      c.setForeground(true);
      expect(c.revealResult(), true);
      await c.flush();
      await restart();
      expect(c.playAgain(), true);
      expect(c.playAgain(), false);
      await c.flush();
      expect(c.round!.id, isNot(firstId));
      c.endRound();
      await c.flush();
      final ended = await repo.load(fallback());
      expect(ended.session.round, null);
      expect(ended.session.history.rounds, 2);
      c.resetHistory();
      await c.flush();
      expect((await repo.load(fallback())).session.history.rounds, 0);
    },
  );
  test(
    'migration is idempotent; legacy source and unrelated keys survive',
    () async {
      final legacy = jsonEncode({
        'version': 1,
        'players': ['Ana', 'Bia', 'Caio'],
        'words': ['en:food:pizza', 'pt-BR:food:pizza', 'en:unknown:nope'],
      });
      storage['game.session.v1'] = legacy;
      storage['settings.language'] = 'pt-BR';
      var calls = 0;
      Future<ClassicSessionLoad> load() => repo.load(
        fallback(),
        migrate: (d) {
          calls++;
          return migrateClassicLegacy(d, fallback());
        },
      );
      final first = await load();
      expect(first.issue, false);
      expect(first.session.config.players.first.name, 'Ana');
      expect(first.session.history.seen.keys, ['en/food/classic.food.pizza']);
      expect((await load()).session.toJson(), first.session.toJson());
      expect(calls, 1);
      expect(storage['game.session.v1'], legacy);
      expect(storage['settings.language'], 'pt-BR');
    },
  );
  test('corrupt snapshot recovers independent config and history', () async {
    final c = ClassicController(
      content: const ClassicContentRepository(),
      config: config(),
    );
    addTearDown(c.dispose);
    c.start();
    final json = c.session.toJson();
    (json['snapshot'] as Map)['index'] = 20;
    storage[ClassicSessionRepository.storageKey] = jsonEncode(json);
    final loaded = await repo.load(fallback());
    expect(loaded.issue, true);
    expect(loaded.session.round, null);
    expect(loaded.session.config.players.first.name, 'Alex');
    expect(loaded.session.history.rounds, 1);
  });
  test('invalid and future schemas never get overwritten on read', () async {
    for (final raw in ['{bad', '{"version":99,"config":{}}']) {
      storage[ClassicSessionRepository.storageKey] = raw;
      final loaded = await repo.load(fallback());
      expect(loaded.issue, true);
      expect(loaded.future, raw.contains('99'));
      expect(storage[ClassicSessionRepository.storageKey], raw);
    }
  });
  test('snapshot is self-contained after catalog update', () async {
    final c = ClassicController(
      content: const ClassicContentRepository(),
      config: config(),
    );
    addTearDown(c.dispose);
    c.start();
    final json = c.session.toJson();
    json['catalogVersion'] = 'removed-catalog';
    final word = (json['snapshot'] as Map)['word'] as Map;
    word['id'] = 'removed-word';
    word['text'] = 'Frozen original';
    storage[ClassicSessionRepository.storageKey] = jsonEncode(json);
    final loaded = await repo.load(fallback());
    expect(loaded.issue, false);
    expect(loaded.session.round!.word.text, 'Frozen original');
  });
  test(
    'writes are queued, capture enqueue state and recover after failure',
    () async {
      final gate = Completer<void>();
      var count = 0;
      final order = <int>[];
      repo = ClassicSessionRepository(
        read: (key) async => storage[key],
        write: (key, raw) async {
          count++;
          if (count == 1) {
            await gate.future;
            throw StateError('injected');
          }
          order.add((jsonDecode(raw) as Map)['revision'] as int);
          storage[key] = raw;
        },
      );
      final failed = expectLater(repo.save(fallback()), throwsStateError);
      final second = repo.save(
        ClassicSession(
          config: config(),
          history: ClassicHistory(),
          revision: 2,
        ),
      );
      final third = repo.save(
        ClassicSession(
          config: config(),
          history: ClassicHistory(),
          revision: 3,
        ),
      );
      expect(count, 0);
      gate.complete();
      await failed;
      await Future.wait([second, third]);
      expect(order, [2, 3]);
      expect((await repo.load(fallback())).session.revision, 3);
    },
  );
  test(
    'write failure blocks transitions, pauses timer and supports retry',
    () async {
      var fail = true;
      repo = ClassicSessionRepository(
        read: (key) async => storage[key],
        write: (key, raw) async {
          if (fail) throw StateError('injected');
          storage[key] = raw;
        },
      );
      final c = ClassicController(
        content: const ClassicContentRepository(),
        config: config(),
        repository: repo,
      );
      addTearDown(c.dispose);
      c.start();
      await c.flush();
      expect(c.persistenceError, true);
      expect(c.markViewed(0), false);
      c.continueWithoutSave();
      expect(c.markViewed(0), true);
      fail = false;
      await c.flush();
      expect(c.persistenceError, false);
      expect(c.continuingWithoutSave, false);
    },
  );
  test('failed migration leaves source available for retry', () async {
    final legacy = jsonEncode({
      'version': 1,
      'players': ['A', 'B', 'C'],
      'words': [],
    });
    storage['game.session.v1'] = legacy;
    final broken = ClassicSessionRepository(
      read: (key) async => storage[key],
      write: (_, _) async => throw StateError('injected'),
    );
    final loaded = await broken.load(
      fallback(),
      migrate: (d) => migrateClassicLegacy(d, fallback()),
    );
    expect(loaded.issue, true);
    expect(storage[ClassicSessionRepository.storageKey], null);
    expect(storage['game.session.v1'], legacy);
  });
}
