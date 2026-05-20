import '../data/content/local_content_repository.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';

final class RematchCarryOver {
  const RematchCarryOver({
    required this.players,
    required this.roundCount,
    required this.questionsPerPlayer,
  });

  final List<Player> players;
  final int roundCount;
  final int questionsPerPlayer;
}

class GameFlowController {
  GameFlowController({
    LocalContentRepository? repository,
    RoundGenerationService? roundGenerationService,
    this.progressionService = const MatchProgressionService(),
    this.scoringService = const VoteScoringService(),
  }) : repository = repository ?? LocalContentRepository(),
       roundGenerationService =
           roundGenerationService ?? RoundGenerationService();

  final LocalContentRepository repository;
  final RoundGenerationService roundGenerationService;
  final MatchProgressionService progressionService;
  final VoteScoringService scoringService;

  SupportedLanguage language = SupportedLanguage.ptBr;
  Category? selectedCategory;
  List<SecretWord> categoryWords = const [];
  MatchSetup? setup;
  MatchState? match;
  RoundResult? currentResult;
  int? pendingRoundCount;
  int? pendingQuestionsPerPlayer;
  RematchCarryOver? rematchCarryOver;

  bool get hasRematchCarryOver => rematchCarryOver != null;

  void configureMatch({
    required int roundCount,
    required int questionsPerPlayer,
  }) {
    pendingRoundCount = roundCount;
    pendingQuestionsPerPlayer = questionsPerPlayer;
  }

  List<Player> get players => match?.players ?? setup?.players ?? const [];
  RoundState? get currentRound => match?.currentRound;
  bool get hasActiveRound => currentRound != null && match != null;

  Future<void> selectCategory(Category category) async {
    selectedCategory = category;
    categoryWords = await repository.wordsForCategory(category.id, language);
  }

  void startMatch(
    List<Player> players, {
    required int roundCount,
    required int questionsPerPlayer,
  }) {
    final category = selectedCategory;
    if (category == null) {
      throw StateError('Select a category before starting a match.');
    }

    setup = MatchSetup(
      categoryId: category.id,
      roundCount: roundCount,
      questionsPerPlayer: questionsPerPlayer,
      players: players,
      language: language,
    );
    match = progressionService.startMatch(setup!);
    _startNextRound();
  }

  void recordVotes(List<Vote> votes) {
    final round = currentRound;
    if (round == null) {
      throw StateError('Cannot record votes without an active round.');
    }

    _replaceCurrentRound(
      RoundState(
        roundNumber: round.roundNumber,
        outPlayerId: round.outPlayerId,
        secretWord: round.secretWord,
        questions: round.questions,
        questionTurns: round.questionTurns,
        phase: RoundPhase.results,
        votes: votes,
      ),
    );
    currentResult = scoringService.calculateRoundResult(
      round: currentRound!,
      players: players,
    );
  }

  bool resolveCurrentRound(RoundResult result) {
    final activeMatch = match;
    final activeSetup = setup;
    if (activeMatch == null || activeSetup == null) {
      throw StateError('Cannot complete a round before a match starts.');
    }

    final completed = progressionService.completeCurrentRound(
      match: activeMatch,
      result: result,
    );
    match = completed;
    currentResult = null;

    if (progressionService.isFinalRoundComplete(
      match: completed,
      roundCount: activeSetup.roundCount,
    )) {
      return true;
    }

    _startNextRound();
    return false;
  }

  List<Player> finalRanking() {
    final activeMatch = match;
    if (activeMatch == null) {
      return const [];
    }
    return progressionService.ranking(activeMatch);
  }

  RoundState? get lastCompletedRound {
    final activeMatch = match;
    if (activeMatch == null) {
      return null;
    }
    for (final round in activeMatch.rounds.reversed) {
      if (round.phase == RoundPhase.complete) {
        return round;
      }
    }
    return null;
  }

  Player? playerById(String playerId) {
    for (final player in players) {
      if (player.id == playerId) {
        return player;
      }
    }
    return null;
  }

  void resetMatch() {
    setup = null;
    match = null;
    currentResult = null;
    pendingRoundCount = null;
    pendingQuestionsPerPlayer = null;
    rematchCarryOver = null;
  }

  void prepareRematchWithNewCategory() {
    final activeSetup = setup;
    if (activeSetup == null) {
      throw StateError('Cannot rematch without a completed match setup.');
    }

    rematchCarryOver = RematchCarryOver(
      players: _freshPlayers(_activePlayersForRematch()),
      roundCount: activeSetup.roundCount,
      questionsPerPlayer: activeSetup.questionsPerPlayer,
    );
    setup = null;
    match = null;
    currentResult = null;
    pendingRoundCount = null;
    pendingQuestionsPerPlayer = null;
    selectedCategory = null;
    categoryWords = const [];
  }

  void rematchKeepingCategory() {
    final activeSetup = setup;
    if (activeSetup == null || selectedCategory == null) {
      throw StateError('Cannot rematch without a selected category and setup.');
    }

    final players = _freshPlayers(_activePlayersForRematch());
    final roundCount = activeSetup.roundCount;
    final questionsPerPlayer = activeSetup.questionsPerPlayer;
    match = null;
    currentResult = null;
    startMatch(
      players,
      roundCount: roundCount,
      questionsPerPlayer: questionsPerPlayer,
    );
  }

  void clearRematchCarryOver() {
    rematchCarryOver = null;
  }

  List<Player> _activePlayersForRematch() {
    final activeMatch = match;
    if (activeMatch != null) {
      return activeMatch.players;
    }

    final activeSetup = setup;
    if (activeSetup != null) {
      return activeSetup.players;
    }

    throw StateError('Cannot rematch without players.');
  }

  static List<Player> _freshPlayers(List<Player> players) {
    return [
      for (final player in players)
        Player(
          id: player.id,
          name: player.name,
          avatarSeed: player.avatarSeed,
        ),
    ];
  }

  void _startNextRound() {
    final activeMatch = match;
    final activeSetup = setup;
    if (activeMatch == null || activeSetup == null) {
      throw StateError('Cannot start a round before a match starts.');
    }

    final round = roundGenerationService.generateRound(
      roundNumber: activeMatch.rounds.length + 1,
      players: activeMatch.players,
      questionsPerPlayer: activeSetup.questionsPerPlayer,
      categoryWords: categoryWords,
      usedWordIds: activeMatch.usedWordIds,
    );
    match = progressionService.startRound(match: activeMatch, round: round);
  }

  void _replaceCurrentRound(RoundState round) {
    final activeMatch = match;
    if (activeMatch == null || activeMatch.currentRound == null) {
      throw StateError('Cannot update a round before a match starts.');
    }

    final rounds = activeMatch.rounds.toList();
    rounds[activeMatch.currentRoundIndex] = round;
    match = MatchState(
      players: activeMatch.players,
      rounds: rounds,
      currentRoundIndex: activeMatch.currentRoundIndex,
      usedWordIds: activeMatch.usedWordIds,
      totalScores: activeMatch.totalScores,
    );
  }
}
