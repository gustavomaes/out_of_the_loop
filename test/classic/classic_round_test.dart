import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/classic/classic_content_repository.dart';
import 'package:outoftheloop/src/domain/classic/classic_models.dart';
import 'package:outoftheloop/src/domain/classic/classic_round_factory.dart';
import 'package:outoftheloop/src/features/classic/application/classic_controller.dart';

class FixedRandom implements Random {
  FixedRandom({this.value = 0, this.integer = 0});
  final double value;
  final int integer;
  @override
  double nextDouble() => value;
  @override
  int nextInt(int max) => integer % max;
  @override
  bool nextBool() => value < .5;
}

ClassicConfig group(
  int n, {
  bool troll = false,
  int? timer,
  int? manual,
  Set<String> categories = const {'food'},
}) => ClassicConfig(
  players: List.generate(n, (i) => ClassicPlayer(id: '$i', name: 'Player $i')),
  categoryIds: categories,
  troll: troll,
  timerMinutes: timer,
  manualImpostors: manual,
);
ClassicRoundCreation create(
  ClassicConfig config, {
  ClassicHistory? history,
  Random? random,
  double probability = .15,
}) =>
    ClassicRoundFactory(
      random: random ?? FixedRandom(),
      trollProbability: probability,
    ).create(
      id: 'round',
      config: config,
      words: const ClassicContentRepository().wordsFor(config),
      categoryNames: {for (final c in classicCategories) c.id: c.name},
      history: history ?? ClassicHistory(),
    );
void distribute(ClassicController c) {
  for (var i = c.revealIndex; i < c.round!.config.players.length; i++) {
    expect(c.markViewed(i), isTrue);
    expect(c.nextPlayer(i), isTrue);
  }
}

void main() {
  test(
    'revocation preserves frozen round and requires acknowledging valid replay selection',
    () {
      var paid = true;
      final c = ClassicController(
        content: const ClassicContentRepository(),
        config: group(3, categories: {'movies'}),
        categoryAllowed: (id) => paid || id != 'movies',
      );
      addTearDown(c.dispose);
      expect(c.start(), isTrue);
      final round = c.round;
      paid = false;
      distribute(c);
      c.revealResult();
      expect(c.round, same(round));
      expect(c.playAgain(), isFalse);
      expect(c.phase, ClassicPhase.result);
      expect(c.accessAdjusted, isTrue);
      expect(c.config.categoryIds, {'food', 'animals', 'sports'});
      expect(c.playAgain(), isTrue);
      expect(c.round!.config.categoryIds, {'food', 'animals', 'sports'});
    },
  );

  test(
    'Auto/manual draw without replacement for every group size; starter independent',
    () {
      for (var n = 3; n <= 20; n++) {
        for (final manual in [null, group(n).maximumImpostors]) {
          final config = group(n, manual: manual);
          final r = create(config, random: FixedRandom(integer: n - 1)).round;
          expect(r.impostorIds.length, config.impostors);
          expect(
            r.impostorIds.every((id) => config.players.any((p) => p.id == id)),
            isTrue,
          );
          expect(r.starterId, '${n - 1}');
          expect(r.troll, isFalse);
          expect(() => r.impostorIds.clear(), throwsUnsupportedError);
        }
      }
      // First player may independently be both starter and impostor.
      final r = create(group(3)).round;
      expect(r.impostorIds, contains(r.starterId));
    },
  );
  test('weighted boundary: previous impostor has .5 weight, others 1', () {
    final h = ClassicHistory(lastImpostors: {'0'});
    expect(
      create(
        group(3),
        history: h,
        random: FixedRandom(value: .1999),
      ).round.impostorIds,
      {'0'},
    );
    expect(
      create(
        group(3),
        history: h,
        random: FixedRandom(value: .2),
      ).round.impostorIds,
      {'1'},
    );
    expect(
      create(
        group(3),
        history: h,
        random: FixedRandom(value: .9999),
      ).round.impostorIds,
      {'2'},
    );
  });
  test('Troll off, below/at threshold and unchanged normal history', () {
    final h = ClassicHistory(lastImpostors: {'2'});
    expect(create(group(3), probability: 1).round.troll, isFalse);
    final troll = create(
      group(20, troll: true),
      history: h,
      random: FixedRandom(value: .14999),
    );
    expect(troll.round.impostorIds.length, 20);
    expect(troll.history.lastImpostors, {'2'});
    expect(
      create(
        group(3, troll: true),
        random: FixedRandom(value: .15),
      ).round.troll,
      isFalse,
    );
    expect(
      () => ClassicRoundFactory(trollProbability: 1.1),
      throwsArgumentError,
    );
  });
  test(
    'unseen selected universe then oldest; no immediate repeat indefinitely',
    () {
      var history = ClassicHistory();
      final config = group(3, categories: {'food', 'animals', 'sports'});
      final seen = <String>{};
      for (var i = 0; i < 160; i++) {
        final previous = history.lastWord;
        final next = create(config, history: history);
        final key = ClassicHistory.wordKey(next.round.word);
        expect(key, isNot(previous));
        if (i < 120) expect(seen.add(key), isTrue);
        history = next.history;
      }
      expect(history.rounds, 160);
      expect(history.seen.length, 120);
    },
  );
  test(
    'equal category draw independent of word count and language validation',
    () {
      const words = [
        ClassicWord(id: 'a', categoryId: 'food', language: 'en', text: 'A'),
        ClassicWord(id: 'b', categoryId: 'animals', language: 'en', text: 'B'),
        ClassicWord(id: 'c', categoryId: 'animals', language: 'en', text: 'C'),
      ];
      final r = ClassicRoundFactory(random: FixedRandom(integer: 1)).create(
        id: 'r',
        config: group(3, categories: {'food', 'animals'}),
        words: words,
        categoryNames: {'food': 'Food', 'animals': 'Animals'},
        history: ClassicHistory(),
      );
      expect(r.round.word.categoryId, 'animals');
      expect(() => create(group(3, categories: {'missing'})), throwsStateError);
      expect(
        () => ClassicRoundFactory().create(
          id: 'r',
          config: ClassicConfig(
            players: group(3).players,
            categoryIds: {'food'},
            contentLanguage: 'pt',
          ),
          words: words,
          categoryNames: {'food': 'Food'},
          history: ClassicHistory(),
        ),
        throwsStateError,
      );
    },
  );
  test(
    'commercial examples excluded for five category rounds with sufficient alternatives',
    () {
      const example = ClassicWord(
        id: 'example',
        categoryId: 'food',
        language: 'en',
        text: 'Example',
        commercialExample: true,
      );
      final real = List.generate(
        5,
        (i) => ClassicWord(
          id: 'real-$i',
          categoryId: 'food',
          language: 'en',
          text: 'Real $i',
        ),
      );
      var h = ClassicHistory();
      for (var i = 0; i < 6; i++) {
        final next = ClassicRoundFactory(random: FixedRandom()).create(
          id: '$i',
          config: group(3),
          words: [example, ...real],
          categoryNames: {'food': 'Food'},
          history: h,
        );
        expect(next.round.word.id, i < 5 ? 'real-$i' : 'example');
        h = next.history;
      }
      final small = ClassicRoundFactory(random: FixedRandom()).create(
        id: 'small',
        config: group(3),
        words: [example, real.first],
        categoryNames: {'food': 'Food'},
        history: ClassicHistory(),
      );
      expect(small.round.word.id, 'example');
    },
  );
  test(
    'start/replay guards, frozen config, viewed guard, interruption and exit',
    () {
      final c = ClassicController(
        content: const ClassicContentRepository(),
        config: group(3),
        factory: ClassicRoundFactory(random: FixedRandom()),
      );
      addTearDown(c.dispose);
      expect(c.nextPlayer(0), isFalse);
      expect(c.start(), isTrue);
      final id = c.round!.id;
      expect(c.start(), isFalse);
      expect(c.round!.id, id);
      expect(c.updateConfig(group(20)), isFalse);
      expect(c.revealResult(), isFalse);
      expect(c.nextPlayer(0), isFalse);
      c.markViewed(0);
      c.setForeground(false);
      expect(c.viewed, isFalse);
      expect(c.markViewed(0), isFalse);
      c.setForeground(true);
      c.markViewed(0);
      expect(c.nextPlayer(0), isTrue);
      expect(c.nextPlayer(0), isFalse);
      distribute(c);
      expect(c.phase, ClassicPhase.discussion);
      expect(c.remaining, isNull);
      expect(c.revealResult(), isTrue);
      expect(c.playAgain(), isTrue);
      expect(c.playAgain(), isFalse);
      expect(c.round!.id, isNot(id));
      expect(c.round!.config.players.length, 3);
      c.endRound();
      expect(c.round, isNull);
      expect(c.phase, ClassicPhase.home);
    },
  );
  test(
    'monotonic timer starts after last role; pause/background/resume/zero do not reveal',
    () {
      var now = Duration.zero;
      final c = ClassicController(
        content: const ClassicContentRepository(),
        config: group(3, timer: 1),
        now: () => now,
      );
      addTearDown(c.dispose);
      c.start();
      now += const Duration(minutes: 2);
      expect(c.remaining, const Duration(minutes: 1));
      distribute(c);
      now += const Duration(seconds: 10);
      expect(c.remaining, const Duration(seconds: 50));
      c.pauseTimer();
      now += const Duration(minutes: 2);
      expect(c.remaining, const Duration(seconds: 50));
      c.resumeTimer();
      now += const Duration(seconds: 5);
      c.setForeground(false);
      c.setForeground(true);
      expect(c.timerRunning, isFalse);
      expect(c.remaining, const Duration(seconds: 45));
      now += const Duration(minutes: 2);
      expect(c.remaining, const Duration(seconds: 45));
      c.resumeTimer();
      now += const Duration(minutes: 1);
      expect(c.remaining, Duration.zero);
      expect(c.phase, ClassicPhase.discussion);
      c.resumeTimer();
      expect(c.timerRunning, isFalse);
    },
  );
  test(
    'unavailable selection fails in a controlled state without consuming history',
    () {
      final c = ClassicController(
        content: const ClassicContentRepository(),
        config: group(3, categories: {'food', 'missing'}),
      );
      addTearDown(c.dispose);
      expect(c.start(), isFalse);
      expect(c.phase, ClassicPhase.home);
      expect(c.history.rounds, 0);
      expect(c.round, isNull);
    },
  );
}
