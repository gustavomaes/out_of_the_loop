import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/classic/classic_catalog_parser.dart';
import 'package:outoftheloop/src/data/classic/classic_content_repository.dart';
import 'package:outoftheloop/src/data/classic/classic_legacy_migration.dart';
import 'package:outoftheloop/src/domain/classic/classic_models.dart';
import 'package:outoftheloop/src/domain/classic/classic_round_factory.dart';

void main() {
  final source = File('assets/content/classic_catalog.json').readAsStringSync();
  Map<String, dynamic> fresh() => jsonDecode(source) as Map<String, dynamic>;
  test(
    'bundled catalog equals source; 120 free + 800 Premium English concepts',
    () {
      final parsed = ClassicCatalog.parse(source);
      final bundled = ClassicContentRepository.catalog;
      expect(bundled.version, parsed.version);
      expect(
        bundled.words.map((w) => '${w.id}/${w.language}/${w.text}'),
        parsed.words.map((w) => '${w.id}/${w.language}/${w.text}'),
      );
      expect(parsed.categories.where((c) => !c.premium), hasLength(3));
      expect(parsed.categories.where((c) => c.premium), hasLength(20));
      final freeIds = parsed.categories
          .where((c) => !c.premium)
          .map((c) => c.id)
          .toSet();
      final free = parsed.words
          .where((w) => w.language == 'en' && freeIds.contains(w.categoryId))
          .map((w) => w.text.toLowerCase())
          .toSet();
      final premium =
          parsed.words
              .where(
                (w) => w.language == 'en' && !freeIds.contains(w.categoryId),
              )
              .map((w) => w.text.toLowerCase())
              .toSet()
            ..removeAll(free);
      expect(free, hasLength(120));
      expect(premium, hasLength(800));
      for (final c in parsed.categories) {
        expect(
          parsed.words.where((w) => w.categoryId == c.id && w.language == 'en'),
          hasLength(greaterThanOrEqualTo(40)),
        );
      }
    },
  );
  test('every legacy localized word is preserved by explicit mapping', () {
    final catalog = ClassicContentRepository.catalog;
    final indexed = {
      for (final w in catalog.words) ClassicHistory.wordKey(w): w,
    };
    for (final bank in ['seed_content', 'us_game_night']) {
      final data = jsonDecode(
        File('assets/content/$bank.json').readAsStringSync(),
      );
      for (final c in data['categories']) {
        for (final w in c['words']) {
          for (final entry in (w['value'] as Map).entries) {
            final key = '${entry.key}:${c['id']}:${w['id']}';
            expect(
              indexed[classicLegacyWordIds[key]]?.text,
              entry.value,
              reason: key,
            );
          }
        }
      }
    }
  });
  test(
    'parser rejects future schema, empty values, duplicate IDs/text and bad references',
    () {
      final changes = <void Function(Map<String, dynamic>)>[
        (d) => d['schemaVersion'] = 2,
        (d) => d['categories'][0]['words'][0]['value']['en'] = ' ',
        (d) => d['categories'][0]['words'][1]['id'] =
            d['categories'][0]['words'][0]['id'],
        (d) => d['categories'][0]['words'][1]['value']['en'] =
            d['categories'][0]['words'][0]['value']['en'],
        (d) => d['categories'][0]['words'][0]['questions'] = [],
        (d) => d['categories'][0]['paywallExampleIds'] = ['missing'],
        (d) => d['legacyWordIds']['en:food:missing'] = 'en/food/missing',
        (d) => d['categories'][0]['words'][0]['value']['xx'] = 'Unknown',
      ];
      for (final change in changes) {
        final data = fresh();
        change(data);
        expect(
          () => ClassicCatalog.parse(jsonEncode(data)),
          throwsFormatException,
        );
      }
      expect(() => ClassicCatalog.parse('[]'), throwsFormatException);
    },
  );
  test(
    'all categories play offline and examples stay out of first five rounds',
    () {
      final repository = const ClassicContentRepository();
      for (final category in classicCategories) {
        final config = ClassicConfig(
          players: [
            for (var i = 0; i < 3; i++)
              ClassicPlayer(id: '$i', name: 'Player $i'),
          ],
          categoryIds: {category.id},
        );
        var history = ClassicHistory();
        final factory = ClassicRoundFactory(random: Random(5));
        final count = repository.wordsFor(config).length;
        for (var i = 0; i <= count; i++) {
          final created = factory.create(
            id: '$i',
            config: config,
            words: repository.wordsFor(config),
            categoryNames: {category.id: category.name},
            history: history,
          );
          if (i < 5) expect(created.round.word.commercialExample, isFalse);
          if (i < count) {
            expect(
              history.seen.containsKey(
                ClassicHistory.wordKey(created.round.word),
              ),
              isFalse,
            );
          }
          expect(
            ClassicHistory.wordKey(created.round.word),
            isNot(history.lastWord),
          );
          history = created.history;
        }
        expect(history.seen, hasLength(count));
      }
    },
  );
}
