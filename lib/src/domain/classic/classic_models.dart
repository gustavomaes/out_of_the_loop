enum ClassicPhase { home, preparing, revealing, discussion, result }

class ClassicPlayer {
  const ClassicPlayer({required this.id, required this.name});
  final String id;
  final String name;
}

/// Immutable configuration; validation is independent from Flutter and storage.
class ClassicConfig {
  ClassicConfig({
    required List<ClassicPlayer> players,
    required Set<String> categoryIds,
    this.contentLanguage = 'en',
    this.manualImpostors,
    this.hint = false,
    this.timerMinutes,
    this.troll = false,
  }) : players = List.unmodifiable(players),
       categoryIds = Set.unmodifiable(categoryIds);
  final List<ClassicPlayer> players;
  final Set<String> categoryIds;
  final String contentLanguage;
  final int? manualImpostors;
  final bool hint;
  final int? timerMinutes;
  final bool troll;

  ClassicConfig copyWith({
    List<ClassicPlayer>? players,
    Set<String>? categoryIds,
    int? manualImpostors,
    bool autoImpostors = false,
    bool? hint,
    int? timerMinutes,
    bool timerOff = false,
    bool? troll,
  }) => ClassicConfig(
    players: players ?? this.players,
    categoryIds: categoryIds ?? this.categoryIds,
    contentLanguage: contentLanguage,
    manualImpostors: autoImpostors
        ? null
        : manualImpostors ?? this.manualImpostors,
    hint: hint ?? this.hint,
    timerMinutes: timerOff ? null : timerMinutes ?? this.timerMinutes,
    troll: troll ?? this.troll,
  );

  int get maximumImpostors => ((players.length - 1) ~/ 2).clamp(1, 6);
  int get impostors =>
      manualImpostors ??
      switch (players.length) {
        <= 5 => 1,
        <= 9 => 2,
        <= 14 => 3,
        _ => 4,
      };
  bool get isValid =>
      players.length >= 3 &&
      players.length <= 20 &&
      players.every(
        (p) => p.id.trim().isNotEmpty && p.name.trim().isNotEmpty,
      ) &&
      players.map((p) => p.id).toSet().length == players.length &&
      categoryIds.isNotEmpty &&
      categoryIds.every((id) => id.trim().isNotEmpty) &&
      contentLanguage.trim().isNotEmpty &&
      (manualImpostors == null ||
          (manualImpostors! >= 1 && manualImpostors! <= maximumImpostors)) &&
      (timerMinutes == null || (timerMinutes! >= 1 && timerMinutes! <= 10));
}

class ClassicWord {
  const ClassicWord({
    required this.id,
    required this.categoryId,
    required this.language,
    required this.text,
    this.commercialExample = false,
  });
  final String id;
  final String categoryId;
  final String language;
  final String text;
  final bool commercialExample;
}
