import '../data/content/us_pack_catalog.dart';
import '../data/session/session_repository.dart';
import '../domain/models/play_history.dart';
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
    this.sessionRepository,
    UsPackCatalog? usPackCatalog,
    bool Function(String)? packAccess,
    RoundGenerationService? roundGenerationService,
    this.progressionService = const MatchProgressionService(),
    this.scoringService = const VoteScoringService(),
  }) : usPackCatalog = usPackCatalog ?? UsPackCatalog(),
       packAccess = packAccess ?? ((_) => false),
       repository = repository ?? LocalContentRepository(),
       roundGenerationService =
           roundGenerationService ?? RoundGenerationService();

  final UsPackCatalog usPackCatalog;
  final bool Function(String) packAccess;
  final SessionRepository? sessionRepository;
  PlayHistory history = PlayHistory();
  GameMode mode = GameMode.guided;
  List<Player> savedPlayers = const [];
  int savedRoundCount = 3;
  int savedQuestionsPerPlayer = 1;
  Future<void> _saving = Future.value();
  bool sessionSaveFailed = false;
  Future<void> loadSession() async {
    final saved = await sessionRepository?.load();
    if (saved == null) return;
    history = saved.history;
    mode = saved.mode;
    savedPlayers = saved.players;
    savedRoundCount = saved.roundCount;
    savedQuestionsPerPlayer = saved.questionsPerPlayer;
  }

  Future<void> flushSession() => _saving;
  void resetHistory() {
    history.clear();
    _saveSession();
  }

  void forgetSavedGroup() {
    savedPlayers = const [];
    _saveSession();
  }

  void _saveSession() {
    final store = sessionRepository;
    if (store == null) return;
    final snapshot = SavedSession(
      history: PlayHistory(words: history.words, questions: history.questions),
      players: List.of(savedPlayers),
      mode: mode,
      roundCount: savedRoundCount,
      questionsPerPlayer: savedQuestionsPerPlayer,
    );
    _saving = _saving.then((_) async {
      try {
        await store.save(snapshot);
        sessionSaveFailed = false;
      } on Object {
        sessionSaveFailed = true;
      }
    });
  }

  final LocalContentRepository repository;
  final RoundGenerationService roundGenerationService;
  final MatchProgressionService progressionService;
  final VoteScoringService scoringService;

  SupportedLanguage language = SupportedLanguage.en;
  Category? selectedCategory;
  SupportedLanguage? _selectedContentLanguage;
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

  Future<void> selectCategory(
    Category category, {
    SupportedLanguage? contentLanguage,
  }) async {
    final selectedLanguage = contentLanguage ?? language;
    if (UsPackCatalog.ids.contains(category.id)) {
      if (selectedLanguage != SupportedLanguage.en ||
          !packAccess(category.id)) {
        throw StateError('Pack is not available.');
      }
      final pack = await usPackCatalog.find(category.id);
      if (pack == null) throw StateError('Pack is missing.');
      categoryWords = pack.content.words;
    } else {
      categoryWords = await repository.wordsForCategory(
        category.id,
        selectedLanguage,
      );
    }
    selectedCategory = category;
    _selectedContentLanguage = selectedLanguage;
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

    if (UsPackCatalog.ids.contains(category.id) && !packAccess(category.id)) {
      throw StateError('Pack access required.');
    }
    setup = MatchSetup(
      categoryId: category.id,
      roundCount: roundCount,
      questionsPerPlayer: questionsPerPlayer,
      players: players,
      language: _selectedContentLanguage ?? language,
      mode: mode,
    );
    savedPlayers = _freshPlayers(players);
    savedRoundCount = roundCount;
    savedQuestionsPerPlayer = questionsPerPlayer;
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
        Player(id: player.id, name: player.name, avatarSeed: player.avatarSeed),
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
      history: history,
      language: activeSetup.language,
      mode: activeSetup.mode,
    );
    match = progressionService.startRound(match: activeMatch, round: round);
    history.record(round, activeSetup.language);
    _saveSession();
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
