import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../domain/services/match_setup_service.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/add_player_button.dart';
import 'widgets/otl_player_tile.dart';
import 'widgets/player_name_field.dart';
import 'widgets/player_setup_footer.dart';
import 'widgets/player_setup_header.dart';

typedef PlayerSetupStartCallback =
    void Function(List<Player> players, int roundCount, int questionsPerPlayer);

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({
    required this.roundCount,
    required this.questionsPerPlayer,
    this.initialPlayers,
    this.categoryWords,
    this.onStart,
    this.onBack,
    this.onSettings,
    MatchSetupService? setupService,
    super.key,
  }) : setupService = setupService ?? const MatchSetupService();

  final int roundCount;
  final int questionsPerPlayer;
  final List<Player>? initialPlayers;
  final List<SecretWord>? categoryWords;
  final PlayerSetupStartCallback? onStart;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;
  final MatchSetupService setupService;

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  final _controller = TextEditingController();
  final _players = <Player>[];
  MatchSetupValidationError? _latestError;
  late var _roundCount = widget.roundCount;
  var _roundCountTouched = true;
  late var _questionsPerPlayer = widget.questionsPerPlayer;
  var _questionsPerPlayerTouched = true;

  List<SecretWord> get _categoryWords =>
      widget.categoryWords ?? _defaultPlayableWords;

  int get _maxQuestionsPerPlayer => MatchSetupService.maxQuestionsPerPlayerFor(
    playerCount: _players.length,
    categoryWords: _categoryWords,
  );

  int get _maxRoundCount => MatchSetupService.maxRoundCountFor(
    playerCount: _players.length,
    questionsPerPlayer: _questionsPerPlayer,
    categoryWords: _categoryWords,
  );

  MatchSetupValidationResult get _validation => widget.setupService.validate(
    players: _players,
    roundCount: _roundCount,
    questionsPerPlayer: _questionsPerPlayer,
    categoryWords: _categoryWords,
  );

  @override
  void initState() {
    super.initState();
    final initialPlayers = widget.initialPlayers;
    if (initialPlayers != null && initialPlayers.isNotEmpty) {
      _players.addAll(initialPlayers);
      _syncQuestionsPerPlayer();
      _syncRoundCount();
    }
  }

  @override
  void didUpdateWidget(covariant PlayerSetupScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.roundCount != widget.roundCount) {
      _roundCount = widget.roundCount;
      _roundCountTouched = false;
    }
    if (oldWidget.questionsPerPlayer != widget.questionsPerPlayer) {
      _questionsPerPlayer = widget.questionsPerPlayer;
      _questionsPerPlayerTouched = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final validation = _validation;
    final canStart = validation.canStart;

    return BrutalistScreenTheme.wrap(
      context,
      Scaffold(
        appBar: OtlBrutalistDiscoveryAppBar(
          onBack: widget.onBack,
          onSettings: widget.onSettings,
        ),
        body: Stack(
          children: [
            const OtlPartyAtmosphere.matchSetup(),
            ListView(
              padding: EdgeInsets.fromLTRB(
                20,
                32,
                20,
                160 + MediaQuery.paddingOf(context).bottom,
              ),
              children: [
                PlayerSetupHeader(l10n: l10n),
                const SizedBox(height: 16),
                PlayerNameField(
                  controller: _controller,
                  hintText: l10n.playerNameHint,
                  onSubmitted: (_) => _addPlayer(),
                ),
                const SizedBox(height: 16),
                AddPlayerButton(
                  label: l10n.addPlayerButton,
                  onPressed: _addPlayer,
                ),
                if (_latestError != null) ...[
                  const SizedBox(height: 12),
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      _messageFor(l10n, _latestError!),
                      key: const Key('player_setup_error'),
                      style: DisplayTypography.plusJakartaBody(
                        color: AppColors.error,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
                if (_players.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  for (var index = 0; index < _players.length; index += 1) ...[
                    if (index > 0) const SizedBox(height: 16),
                    OtlPlayerTile(
                      name: _players[index].name,
                      avatarSeed: _players[index].avatarSeed,
                      backgroundColor: playerCardColorForIndex(index),
                      removeTooltip: l10n.playerSetupRemovePlayer(
                        _players[index].name,
                      ),
                      onRemove: () => _removePlayer(index),
                    ),
                  ],
                ],
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PlayerSetupFooter(
                label: l10n.playerSetupStartGame,
                enabled: canStart,
                onPressed: canStart
                    ? () => widget.onStart?.call(
                        _players,
                        _roundCount,
                        _questionsPerPlayer,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _syncRoundCount() {
    final nextValue = MatchSetupService.effectiveRoundCount(
      roundCount: _roundCount,
      maxRoundCount: _maxRoundCount,
      touched: _roundCountTouched,
    );

    if (nextValue == _roundCount) {
      return;
    }
    setState(() => _roundCount = nextValue);
  }

  void _syncQuestionsPerPlayer() {
    final maxValue = _maxQuestionsPerPlayer;
    final recommended = MatchSetupService.recommendedQuestionsPerPlayer(
      _players.length,
    );
    final nextValue = _questionsPerPlayerTouched
        ? _questionsPerPlayer.clamp(MatchSetup.minQuestionsPerPlayer, maxValue)
        : recommended.clamp(MatchSetup.minQuestionsPerPlayer, maxValue);

    if (nextValue == _questionsPerPlayer) {
      return;
    }
    setState(() => _questionsPerPlayer = nextValue);
    _syncRoundCount();
  }

  void _addPlayer() {
    final name = _controller.text.trim();
    final candidate = Player(
      id: 'player-${_players.length + 1}',
      name: name,
      avatarSeed: name,
    );
    final nextPlayers = [candidate, ..._players];
    final validation = widget.setupService.validate(
      players: nextPlayers,
      roundCount: _roundCount,
      questionsPerPlayer: _questionsPerPlayer,
      categoryWords: _categoryWords,
    );

    final blockingError = validation.errors
        .where(
          (error) =>
              error == MatchSetupValidationError.emptyPlayerName ||
              error == MatchSetupValidationError.duplicatePlayerName ||
              error == MatchSetupValidationError.tooManyPlayers,
        )
        .firstOrNull;
    if (blockingError != null) {
      setState(() => _latestError = blockingError);
      return;
    }

    setState(() {
      _players.insert(0, candidate);
      _latestError = null;
      _controller.clear();
    });
    _syncQuestionsPerPlayer();
    _syncRoundCount();
  }

  void _removePlayer(int index) {
    setState(() {
      _players.removeAt(index);
      _latestError = null;
    });
    _syncQuestionsPerPlayer();
    _syncRoundCount();
  }

  String _messageFor(
    AppLocalizations l10n,
    MatchSetupValidationError error,
  ) {
    return switch (error) {
      MatchSetupValidationError.emptyPlayerName =>
        l10n.playerSetupErrorEmptyName,
      MatchSetupValidationError.duplicatePlayerName =>
        l10n.playerSetupErrorDuplicateName,
      MatchSetupValidationError.tooManyPlayers =>
        l10n.playerSetupErrorTooManyPlayers,
      MatchSetupValidationError.tooFewPlayers =>
        l10n.playerSetupErrorTooFewPlayers,
      MatchSetupValidationError.invalidRoundCount =>
        l10n.playerSetupErrorInvalidRoundCount,
      MatchSetupValidationError.invalidQuestionsPerPlayer =>
        l10n.playerSetupErrorInvalidQuestions,
      MatchSetupValidationError.insufficientPlayableWords =>
        l10n.playerSetupErrorInsufficientWords,
      MatchSetupValidationError.insufficientQuestionsPerWord =>
        l10n.playerSetupErrorInsufficientQuestions,
    };
  }
}

final _defaultPlayableWords = List.generate(
  5,
  (wordIndex) => SecretWord(
    id: 'word-$wordIndex',
    categoryId: 'food',
    value: LocalizedText({
      SupportedLanguage.ptBr: 'Palavra ${wordIndex + 1}',
      SupportedLanguage.en: 'Word ${wordIndex + 1}',
      SupportedLanguage.es: 'Palabra ${wordIndex + 1}',
      SupportedLanguage.hi: 'Word ${wordIndex + 1}',
    }),
    questions: List.generate(
      9,
      (questionIndex) => Question(
        id: 'word-$wordIndex-q$questionIndex',
        wordId: 'word-$wordIndex',
        text: LocalizedText({
          SupportedLanguage.ptBr: 'Pergunta ${questionIndex + 1}',
          SupportedLanguage.en: 'Question ${questionIndex + 1}',
          SupportedLanguage.es: 'Pregunta ${questionIndex + 1}',
          SupportedLanguage.hi: 'Question ${questionIndex + 1}',
        }),
      ),
    ),
  ),
);
