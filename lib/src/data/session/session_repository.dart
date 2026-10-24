import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/models.dart';
import '../../domain/models/play_history.dart';

class SavedSession {
  SavedSession({
    PlayHistory? history,
    this.players = const [],
    this.mode = GameMode.guided,
    this.roundCount = 3,
    this.questionsPerPlayer = 1,
  }) : history = history ?? PlayHistory();
  final PlayHistory history;
  final List<Player> players;
  final GameMode mode;
  final int roundCount;
  final int questionsPerPlayer;
}

/// Local only: names never become analytics or purchase identities.
class SessionRepository {
  const SessionRepository();
  static const storageKey = 'game.session.v1';
  Future<SavedSession> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(storageKey);
      if (raw == null) return SavedSession();
      final data = jsonDecode(raw) as Map<String, dynamic>;
      if (data['version'] != 1) return SavedSession();
      List<String> strings(dynamic value, int cap) =>
          value is List ? value.whereType<String>().take(cap).toList() : [];
      final names = strings(data['players'], MatchSetup.maxPlayers);
      final seen = <String>{};
      final players = <Player>[];
      for (final name in names) {
        final trimmed = name.trim();
        if (trimmed.isEmpty || !seen.add(trimmed.toLowerCase())) continue;
        players.add(
          Player(
            id: 'saved-${players.length}',
            name: trimmed,
            avatarSeed: trimmed,
          ),
        );
      }
      return SavedSession(
        history: PlayHistory(
          words: strings(data['words'], 2000),
          questions: strings(data['questions'], 8000),
        ),
        players: players,
        mode: data['mode'] == 'free' ? GameMode.free : GameMode.guided,
        roundCount: data['roundCount'] is int
            ? (data['roundCount'] as int).clamp(1, 5)
            : 3,
        questionsPerPlayer: data['questionsPerPlayer'] is int
            ? (data['questionsPerPlayer'] as int).clamp(1, 3)
            : 1,
      );
    } on Object {
      return SavedSession();
    }
  }

  Future<void> save(SavedSession state) async {
    final json = jsonEncode({
      'version': 1,
      'words': state.history.words,
      'questions': state.history.questions,
      'players': state.players.map((p) => p.name).toList(),
      'mode': state.mode.name,
      'roundCount': state.roundCount,
      'questionsPerPlayer': state.questionsPerPlayer,
    });
    final prefs = await SharedPreferences.getInstance();
    if (!await prefs.setString(storageKey, json)) {
      throw StateError('Could not save session.');
    }
  }
}
