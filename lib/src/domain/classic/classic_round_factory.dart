import 'dart:math';
import 'classic_models.dart';

/// In-memory recency. Keys include language and category to isolate catalogs.
class ClassicHistory {
  ClassicHistory({
    Map<String, int> seen = const {},
    Map<String, int> categoryRounds = const {},
    Set<String> lastImpostors = const {},
    this.lastWord,
    this.rounds = 0,
  }) : seen = Map.unmodifiable(seen),
       categoryRounds = Map.unmodifiable(categoryRounds),
       lastImpostors = Set.unmodifiable(lastImpostors);
  final Map<String, int> seen;
  final Map<String, int> categoryRounds;
  final Set<String> lastImpostors;
  final String? lastWord;
  final int rounds;
  static String categoryKey(ClassicWord w) => '${w.language}/${w.categoryId}';
  static String wordKey(ClassicWord w) => '${categoryKey(w)}/${w.id}';
}

class ClassicRound {
  ClassicRound({
    required this.id,
    required this.config,
    required this.word,
    required this.categoryName,
    required Set<String> impostorIds,
    required this.starterId,
    required this.troll,
  }) : impostorIds = Set.unmodifiable(impostorIds);
  final String id;
  final ClassicConfig config;
  final ClassicWord word;
  final String categoryName;
  final Set<String> impostorIds;
  final String starterId;
  final bool troll;
}

class ClassicRoundCreation {
  const ClassicRoundCreation(this.round, this.history);
  final ClassicRound round;
  final ClassicHistory history;
}

/// No UI or storage dependencies. Random is injected for deterministic tests.
class ClassicRoundFactory {
  ClassicRoundFactory({Random? random, this.trollProbability = .15})
    : random = random ?? Random.secure() {
    if (trollProbability < 0 ||
        trollProbability > 1 ||
        trollProbability.isNaN) {
      throw ArgumentError.value(trollProbability);
    }
  }
  final Random random;
  final double trollProbability;

  ClassicRoundCreation create({
    required String id,
    required ClassicConfig config,
    required List<ClassicWord> words,
    required Map<String, String> categoryNames,
    required ClassicHistory history,
  }) {
    if (!config.isValid) throw StateError('Invalid configuration');
    final available = words
        .where(
          (w) =>
              config.categoryIds.contains(w.categoryId) &&
              w.language == config.contentLanguage &&
              w.text.trim().isNotEmpty,
        )
        .toList();
    // Never silently substitute another category or language.
    if (config.categoryIds.any(
      (c) =>
          !available.any((w) => w.categoryId == c) ||
          !categoryNames.containsKey(c),
    )) {
      throw StateError('Selected content unavailable');
    }
    var candidates = available
        .where(
          (w) =>
              !w.commercialExample ||
              (history.categoryRounds[ClassicHistory.categoryKey(w)] ?? 0) >=
                  5 ||
              available
                      .where(
                        (other) =>
                            other.categoryId == w.categoryId &&
                            !other.commercialExample,
                      )
                      .length <
                  5,
        )
        .toList();
    if (candidates.length > 1) {
      candidates.removeWhere(
        (w) => ClassicHistory.wordKey(w) == history.lastWord,
      );
    }
    final unseen = candidates
        .where((w) => !history.seen.containsKey(ClassicHistory.wordKey(w)))
        .toList();
    if (unseen.isNotEmpty) {
      candidates = unseen;
    } else {
      final oldest = candidates
          .map((w) => history.seen[ClassicHistory.wordKey(w)]!)
          .reduce(min);
      candidates = candidates
          .where((w) => history.seen[ClassicHistory.wordKey(w)] == oldest)
          .toList();
    }
    final categories = candidates.map((w) => w.categoryId).toSet().toList();
    final category = categories[random.nextInt(categories.length)];
    final pool = candidates.where((w) => w.categoryId == category).toList();
    final word = pool[random.nextInt(pool.length)];
    final troll = config.troll && random.nextDouble() < trollProbability;
    final impostors = <String>{};
    final remaining = config.players.toList();
    if (troll) {
      impostors.addAll(remaining.map((p) => p.id));
    } else {
      for (var i = 0; i < config.impostors; i++) {
        double weight(ClassicPlayer p) =>
            history.lastImpostors.contains(p.id) ? .5 : 1;
        var draw =
            random.nextDouble() *
            remaining.fold<double>(0, (sum, p) => sum + weight(p));
        var index = remaining.length - 1;
        for (var j = 0; j < remaining.length; j++) {
          draw -= weight(remaining[j]);
          if (draw < 0) {
            index = j;
            break;
          }
        }
        impostors.add(remaining.removeAt(index).id);
      }
    }
    final starter = config.players[random.nextInt(config.players.length)].id;
    final round = ClassicRound(
      id: id,
      config: config,
      word: word,
      categoryName: categoryNames[category]!,
      impostorIds: impostors,
      starterId: starter,
      troll: troll,
    );
    final key = ClassicHistory.wordKey(word);
    final categoryKey = ClassicHistory.categoryKey(word);
    return ClassicRoundCreation(
      round,
      ClassicHistory(
        seen: {...history.seen, key: history.rounds + 1},
        categoryRounds: {
          ...history.categoryRounds,
          categoryKey: (history.categoryRounds[categoryKey] ?? 0) + 1,
        },
        lastImpostors: troll ? history.lastImpostors : impostors,
        lastWord: key,
        rounds: history.rounds + 1,
      ),
    );
  }
}
