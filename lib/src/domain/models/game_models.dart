enum SupportedLanguage {
  ptBr('pt-BR'),
  en('en'),
  es('es'),
  hi('hi');

  const SupportedLanguage(this.code);

  final String code;
}

enum PlayerRole { inside, out }

enum RoundPhase { reveal, questions, voting, results, guess, complete }

final class LocalizedText {
  const LocalizedText(this.values);

  final Map<SupportedLanguage, String> values;

  String valueFor(SupportedLanguage language) => values[language] ?? '';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalizedText && _mapEquals(values, other.values);

  @override
  int get hashCode => _mapHash(values);
}

final class Player {
  const Player({
    required this.id,
    required this.name,
    required this.avatarSeed,
    this.totalScore = 0,
  });

  final String id;
  final String name;
  final String avatarSeed;
  final int totalScore;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Player &&
          id == other.id &&
          name == other.name &&
          avatarSeed == other.avatarSeed &&
          totalScore == other.totalScore;

  @override
  int get hashCode => Object.hash(id, name, avatarSeed, totalScore);
}

final class Category {
  const Category({
    required this.id,
    required this.name,
    required this.primaryArgb,
    required this.secondaryArgb,
    this.iconKey,
  });

  final String id;
  final LocalizedText name;
  final int primaryArgb;
  final int secondaryArgb;
  final String? iconKey;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          id == other.id &&
          name == other.name &&
          primaryArgb == other.primaryArgb &&
          secondaryArgb == other.secondaryArgb &&
          iconKey == other.iconKey;

  @override
  int get hashCode =>
      Object.hash(id, name, primaryArgb, secondaryArgb, iconKey);
}

final class Question {
  const Question({required this.id, required this.wordId, required this.text});

  final String id;
  final String wordId;
  final LocalizedText text;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question &&
          id == other.id &&
          wordId == other.wordId &&
          text == other.text;

  @override
  int get hashCode => Object.hash(id, wordId, text);
}

final class QuestionTurn {
  const QuestionTurn({required this.question, required this.playerId});

  final Question question;
  final String playerId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionTurn &&
          question == other.question &&
          playerId == other.playerId;

  @override
  int get hashCode => Object.hash(question, playerId);
}

final class SecretWord {
  SecretWord({
    required this.id,
    required this.categoryId,
    required this.value,
    required List<Question> questions,
  }) : questions = List.unmodifiable(questions);

  final String id;
  final String categoryId;
  final LocalizedText value;
  final List<Question> questions;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecretWord &&
          id == other.id &&
          categoryId == other.categoryId &&
          value == other.value &&
          _listEquals(questions, other.questions);

  @override
  int get hashCode =>
      Object.hash(id, categoryId, value, Object.hashAll(questions));
}

final class MatchSetup {
  MatchSetup({
    required this.categoryId,
    required this.roundCount,
    required this.questionsPerPlayer,
    required List<Player> players,
    required this.language,
  }) : players = List.unmodifiable(players);

  static const minPlayers = 3;
  static const maxPlayers = 9;
  static const minRoundCount = 1;
  static const maxRoundCount = 5;
  static const recommendedRoundCount = 3;
  static const minQuestionsPerPlayer = 1;
  static const maxQuestionsPerPlayer = 3;

  final String categoryId;
  final int roundCount;
  final int questionsPerPlayer;
  final List<Player> players;
  final SupportedLanguage language;

  int get questionsPerRound => players.length * questionsPerPlayer;

  bool get hasSupportedPlayerCount => isSupportedPlayerCount(players.length);

  static bool isSupportedPlayerCount(int count) =>
      count >= minPlayers && count <= maxPlayers;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchSetup &&
          categoryId == other.categoryId &&
          roundCount == other.roundCount &&
          questionsPerPlayer == other.questionsPerPlayer &&
          _listEquals(players, other.players) &&
          language == other.language;

  @override
  int get hashCode => Object.hash(
    categoryId,
    roundCount,
    questionsPerPlayer,
    Object.hashAll(players),
    language,
  );
}

final class MatchState {
  MatchState({
    required List<Player> players,
    required List<RoundState> rounds,
    required this.currentRoundIndex,
    required Set<String> usedWordIds,
    required Map<String, int> totalScores,
  }) : players = List.unmodifiable(players),
       rounds = List.unmodifiable(rounds),
       usedWordIds = Set.unmodifiable(usedWordIds),
       totalScores = Map.unmodifiable(totalScores);

  final List<Player> players;
  final List<RoundState> rounds;
  final int currentRoundIndex;
  final Set<String> usedWordIds;
  final Map<String, int> totalScores;

  RoundState? get currentRound =>
      currentRoundIndex >= 0 && currentRoundIndex < rounds.length
      ? rounds[currentRoundIndex]
      : null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchState &&
          _listEquals(players, other.players) &&
          _listEquals(rounds, other.rounds) &&
          currentRoundIndex == other.currentRoundIndex &&
          _setEquals(usedWordIds, other.usedWordIds) &&
          _mapEquals(totalScores, other.totalScores);

  @override
  int get hashCode => Object.hash(
    Object.hashAll(players),
    Object.hashAll(rounds),
    currentRoundIndex,
    Object.hashAll(usedWordIds),
    _mapHash(totalScores),
  );
}

final class RoundState {
  RoundState({
    required this.roundNumber,
    required this.outPlayerId,
    required this.secretWord,
    required List<Question> questions,
    required List<QuestionTurn> questionTurns,
    required this.phase,
    List<Vote> votes = const [],
    List<ScoreEvent> scoreEvents = const [],
  }) : questions = List.unmodifiable(questions),
       questionTurns = List.unmodifiable(questionTurns),
       votes = List.unmodifiable(votes),
       scoreEvents = List.unmodifiable(scoreEvents);

  final int roundNumber;
  final String outPlayerId;
  final SecretWord secretWord;
  final List<Question> questions;
  final List<QuestionTurn> questionTurns;
  final RoundPhase phase;
  final List<Vote> votes;
  final List<ScoreEvent> scoreEvents;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundState &&
          roundNumber == other.roundNumber &&
          outPlayerId == other.outPlayerId &&
          secretWord == other.secretWord &&
          _listEquals(questions, other.questions) &&
          _listEquals(questionTurns, other.questionTurns) &&
          phase == other.phase &&
          _listEquals(votes, other.votes) &&
          _listEquals(scoreEvents, other.scoreEvents);

  @override
  int get hashCode => Object.hash(
    roundNumber,
    outPlayerId,
    secretWord,
    Object.hashAll(questions),
    Object.hashAll(questionTurns),
    phase,
    Object.hashAll(votes),
    Object.hashAll(scoreEvents),
  );
}

final class Vote {
  const Vote({required this.voterId, required this.suspectId});

  final String voterId;
  final String suspectId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vote && voterId == other.voterId && suspectId == other.suspectId;

  @override
  int get hashCode => Object.hash(voterId, suspectId);
}

final class RoundResult {
  RoundResult({
    required this.outPlayerId,
    required Map<String, int> voteCounts,
    required this.wasOutFoundByMajority,
    required this.guessWasCorrect,
    required List<ScoreEvent> scoreEvents,
  }) : voteCounts = Map.unmodifiable(voteCounts),
       scoreEvents = List.unmodifiable(scoreEvents);

  final String outPlayerId;
  final Map<String, int> voteCounts;
  final bool wasOutFoundByMajority;
  final bool? guessWasCorrect;
  final List<ScoreEvent> scoreEvents;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundResult &&
          outPlayerId == other.outPlayerId &&
          _mapEquals(voteCounts, other.voteCounts) &&
          wasOutFoundByMajority == other.wasOutFoundByMajority &&
          guessWasCorrect == other.guessWasCorrect &&
          _listEquals(scoreEvents, other.scoreEvents);

  @override
  int get hashCode => Object.hash(
    outPlayerId,
    _mapHash(voteCounts),
    wasOutFoundByMajority,
    guessWasCorrect,
    Object.hashAll(scoreEvents),
  );
}

final class ScoreEvent {
  const ScoreEvent({
    required this.playerId,
    required this.points,
    required this.reason,
  });

  final String playerId;
  final int points;
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreEvent &&
          playerId == other.playerId &&
          points == other.points &&
          reason == other.reason;

  @override
  int get hashCode => Object.hash(playerId, points, reason);
}

bool _listEquals<T>(List<T> left, List<T> right) {
  if (identical(left, right)) {
    return true;
  }
  if (left.length != right.length) {
    return false;
  }
  for (var i = 0; i < left.length; i += 1) {
    if (left[i] != right[i]) {
      return false;
    }
  }
  return true;
}

bool _setEquals<T>(Set<T> left, Set<T> right) {
  if (identical(left, right)) {
    return true;
  }
  if (left.length != right.length) {
    return false;
  }
  for (final value in left) {
    if (!right.contains(value)) {
      return false;
    }
  }
  return true;
}

bool _mapEquals<K, V>(Map<K, V> left, Map<K, V> right) {
  if (identical(left, right)) {
    return true;
  }
  if (left.length != right.length) {
    return false;
  }
  for (final entry in left.entries) {
    if (!right.containsKey(entry.key) || right[entry.key] != entry.value) {
      return false;
    }
  }
  return true;
}

int _mapHash<K, V>(Map<K, V> map) {
  final entryHashes =
      map.entries.map((entry) => Object.hash(entry.key, entry.value)).toList()
        ..sort();
  return Object.hashAll(entryHashes);
}
