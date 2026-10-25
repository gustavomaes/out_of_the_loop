import '../../domain/classic/classic_models.dart';
import '../../domain/classic/classic_round_factory.dart';
import 'classic_session_repository.dart';

// Explicit equivalences audited against both legacy assets and the initial catalog.
const classicLegacyWordIds = <String, String>{
  'en:food:pizza': 'en/food/classic.food.pizza',
  'en:food:sushi': 'en/food/classic.food.sushi',
  'en:food:ice_cream': 'en/food/classic.food.ice_cream',
  'en:food:popcorn': 'en/food/classic.food.popcorn',
  'en:food:chocolate': 'en/food/classic.food.chocolate',
  'en:food:cheese': 'en/food/classic.food.cheese',
  'en:sports:soccer': 'en/sports/classic.sports.soccer',
  'en:sports:basketball': 'en/sports/classic.sports.basketball',
  'en:sports:tennis': 'en/sports/classic.sports.tennis',
  'en:sports:volleyball': 'en/sports/classic.sports.volleyball',
  'en:sports:swimming': 'en/sports/classic.sports.swimming',
  'en:sports:cycling': 'en/sports/classic.sports.cycling',
  'en:sports:baseball': 'en/sports/classic.sports.baseball',
  'en:sports:boxing': 'en/sports/classic.sports.boxing',
  'en:sports:skiing': 'en/sports/classic.sports.skiing',
  'en:sports:surfing': 'en/sports/classic.sports.surfing',
  'en:sports:skateboarding': 'en/sports/classic.sports.skateboarding',
  'en:sports:golf': 'en/sports/classic.sports.golf',
  'en:animals:elephant': 'en/animals/classic.animals.elephant',
  'en:animals:lion': 'en/animals/classic.animals.lion',
  'en:animals:giraffe': 'en/animals/classic.animals.giraffe',
  'en:animals:penguin': 'en/animals/classic.animals.penguin',
  'en:animals:dolphin': 'en/animals/classic.animals.dolphin',
  'en:animals:rabbit': 'en/animals/classic.animals.rabbit',
  'en:animals:panda': 'en/animals/classic.animals.panda',
  'en:animals:kangaroo': 'en/animals/classic.animals.kangaroo',
  'en:animals:turtle': 'en/animals/classic.animals.turtle',
  'en:animals:octopus': 'en/animals/classic.animals.octopus',
  'en:animals:butterfly': 'en/animals/classic.animals.butterfly',
  'en:us_backyard:us_backyard_09': 'en/food/classic.food.lemonade',
  'en:us_backyard:us_backyard_13': 'en/food/classic.food.watermelon',
};

ClassicSession migrateClassicLegacy(
  Map<String, dynamic> data,
  ClassicSession fallback,
) {
  if (data['version'] != 1) {
    throw const FormatException('Unknown legacy schema');
  }
  final players = <ClassicPlayer>[];
  for (final name in (data['players'] as List).cast<String>().take(20)) {
    if (name.trim().isNotEmpty) {
      players.add(
        ClassicPlayer(id: 'legacy-${players.length}', name: name.trim()),
      );
    }
  }
  final seen = <String, int>{};
  var ordinal = 0;
  var unmapped = 0;
  for (final old in (data['words'] as List).cast<String>()) {
    final mapped = classicLegacyWordIds[old];
    if (mapped != null) {
      seen.remove(mapped);
      seen[mapped] = ++ordinal;
    } else {
      unmapped++;
    }
  }
  return ClassicSession(
    config: players.length >= 3
        ? fallback.config.copyWith(players: players)
        : fallback.config,
    history: ClassicHistory(
      seen: seen,
      rounds: ordinal,
      lastWord: seen.isEmpty ? null : seen.keys.last,
    ),
    preferences: {...fallback.preferences, 'migration.unmappedWords': unmapped},
  );
}
