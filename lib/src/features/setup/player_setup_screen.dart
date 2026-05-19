import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../domain/services/match_setup_service.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';
import 'widgets/otl_player_tile.dart';

typedef PlayerSetupStartCallback =
    void Function(List<Player> players, int roundCount, int questionsPerPlayer);

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({
    required this.roundCount,
    required this.questionsPerPlayer,
    this.categoryWords,
    this.onStart,
    this.onBack,
    this.onSettings,
    MatchSetupService? setupService,
    super.key,
  }) : setupService = setupService ?? const MatchSetupService();

  final int roundCount;
  final int questionsPerPlayer;
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
            const _PlayerSetupAtmosphere(),
            ListView(
              padding: EdgeInsets.fromLTRB(
                20,
                32,
                20,
                160 + MediaQuery.paddingOf(context).bottom,
              ),
              children: [
                _PlayerSetupHeader(l10n: l10n),
                const SizedBox(height: 16),
                _PlayerNameField(
                  controller: _controller,
                  hintText: l10n.playerNameHint,
                  onSubmitted: (_) => _addPlayer(),
                ),
                const SizedBox(height: 16),
                _AddPlayerButton(
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
                        color: const Color(0xFFFF6B6B),
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
              child: _PlayerSetupFooter(
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

class _PlayerSetupHeader extends StatelessWidget {
  const _PlayerSetupHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.playerSetupTitleLine1,
          style: DisplayTypography.rubikPlayerSetupTitle(
            color: BrutalistColors.lime,
          ),
        ),
        Text(
          l10n.playerSetupTitleLine2,
          style: DisplayTypography.rubikPlayerSetupTitle(
            color: BrutalistColors.lime,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 4),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Transform.translate(
                  offset: const Offset(4, 4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: BrutalistColors.playerCountBadgeBackground,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Text(
                    l10n.playerSetupPlayerCountBadge,
                    key: const Key('player_setup_count_badge'),
                    style: DisplayTypography.spaceGroteskMeta(
                      color: BrutalistColors.playerCountBadgeText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlayerNameField extends StatelessWidget {
  const _PlayerNameField({
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onSubmitted;

  static const _height = 64.0;
  static const _shadowOffset = 4.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _shadowOffset, bottom: _shadowOffset),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(_shadowOffset, _shadowOffset),
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: _height,
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.done,
              style: DisplayTypography.plusJakartaBody(
                color: BrutalistColors.cardText,
              ),
              cursorColor: BrutalistColors.lime,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: DisplayTypography.plusJakartaBody(
                  color: BrutalistColors.inputHint,
                ),
                filled: true,
                fillColor: BrutalistColors.cardBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 4),
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 4),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPlayerButton extends StatelessWidget {
  const _AddPlayerButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  static const _height = 64.0;
  static const _shadowOffset = 4.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _shadowOffset, bottom: _shadowOffset),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(_shadowOffset, _shadowOffset),
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: _height,
            width: double.infinity,
            child: Material(
              color: BrutalistColors.lime,
              child: InkWell(
                onTap: onPressed,
                child: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: BrutalistColors.homePrimaryButtonText,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: DisplayTypography.rubikHomeButton(
                          color: BrutalistColors.homePrimaryButtonText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerSetupFooter extends StatelessWidget {
  const _PlayerSetupFooter({
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  static const _height = 80.0;
  static const _shadowOffset = 8.0;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: BrutalistColors.footerScrim),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomPadding),
            child: Opacity(
              opacity: enabled ? 1 : 0.45,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: _shadowOffset,
                  bottom: _shadowOffset,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Transform.translate(
                        offset: const Offset(_shadowOffset, _shadowOffset),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height,
                      width: double.infinity,
                      child: Material(
                        color: BrutalistColors.lime,
                        child: InkWell(
                          onTap: onPressed,
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 4,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  label,
                                  style: DisplayTypography.rubikPlayerSetupCta(
                                    color: BrutalistColors.homePrimaryButtonText,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.play_arrow,
                                  color: BrutalistColors.homePrimaryButtonText,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerSetupAtmosphere extends StatelessWidget {
  const _PlayerSetupAtmosphere();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: 96,
            child: _glow(color: BrutalistColors.playerCardPink),
          ),
          Positioned(
            left: -40,
            bottom: 212,
            child: _glow(color: BrutalistColors.lime),
          ),
        ],
      ),
    );
  }

  Widget _glow({required Color color}) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Opacity(
        opacity: 0.2,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
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
