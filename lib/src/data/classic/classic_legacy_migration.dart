import 'classic_content_repository.dart';
import '../../domain/classic/classic_models.dart';
import '../../domain/classic/classic_round_factory.dart';
import 'classic_session_repository.dart';

// Every legacy localized value maps to an equivalent in the versioned catalog.
final classicLegacyWordIds = ClassicContentRepository.catalog.legacyWordIds;

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
