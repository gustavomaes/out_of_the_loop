import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../domain/services/match_setup_service.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

typedef PlayerSetupStartCallback =
    void Function(List<Player> players, int questionsPerPlayer);

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({
    this.roundCount = 5,
    this.categoryWords,
    this.onStart,
    MatchSetupService? setupService,
    super.key,
  }) : setupService = setupService ?? const MatchSetupService();

  final int roundCount;
  final List<SecretWord>? categoryWords;
  final PlayerSetupStartCallback? onStart;
  final MatchSetupService setupService;

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  final _controller = TextEditingController();
  final _players = <Player>[];
  MatchSetupValidationError? _latestError;
  var _questionsPerPlayer = MatchSetupService.recommendedQuestionsPerPlayer(0);
  var _questionsPerPlayerTouched = false;

  List<SecretWord> get _categoryWords =>
      widget.categoryWords ?? _defaultPlayableWords;

  int get _maxQuestionsPerPlayer => MatchSetupService.maxQuestionsPerPlayerFor(
    playerCount: _players.length,
    categoryWords: _categoryWords,
  );

  MatchSetupValidationResult get _validation => widget.setupService.validate(
    players: _players,
    roundCount: widget.roundCount,
    questionsPerPlayer: _questionsPerPlayer,
    categoryWords: _categoryWords,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validation = _validation;
    final canStart = validation.canStart;

    return AppShell(
      routeName: AppRoutes.players,
      title: 'Players',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                Text('QUEM VAI JOGAR?', style: AppTypography.emphasis),
                const SizedBox(height: AppSpacing.xs),
                const Text('Quem vai jogar?', style: AppTypography.h2),
                const SizedBox(height: AppSpacing.xs),
                Text('3-9 jogadores', style: AppTypography.body),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: OtlTextField(
                        controller: _controller,
                        hintText: 'Nome do jogador',
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    OtlButton.secondary(label: 'ADD', onPressed: _addPlayer),
                  ],
                ),
                if (_latestError != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      _messageFor(_latestError!),
                      key: const Key('player_setup_error'),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                _QuestionsPerPlayerSelector(
                  value: _questionsPerPlayer,
                  maxValue: _maxQuestionsPerPlayer,
                  playerCount: _players.length,
                  onChanged: _setQuestionsPerPlayer,
                ),
                const SizedBox(height: AppSpacing.lg),
                for (var index = 0; index < _players.length; index += 1) ...[
                  if (index > 0) const SizedBox(height: AppSpacing.sm),
                  OtlCard(
                    selected: index == 0,
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}',
                          style: AppTypography.emphasis.copyWith(
                            color: AppColors.primaryMain,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        PlayerAvatar(
                          name: _players[index].name,
                          seed: _players[index].avatarSeed,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            _players[index].name,
                            style: AppTypography.body.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            '${_players.length}/9 players ready',
            style: AppTypography.label,
            textAlign: TextAlign.center,
          ),
          if (_players.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${_players.length * _questionsPerPlayer} perguntas nesta rodada',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: AppRadius.borderLg,
              border: Border.all(color: AppColors.borderDefault),
              boxShadow: canStart ? AppShadows.glow : AppShadows.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: OtlButton.primary(
                label: 'START MATCH',
                onPressed: canStart
                    ? () => widget.onStart?.call(
                        _players,
                        _questionsPerPlayer,
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setQuestionsPerPlayer(int value) {
    setState(() {
      _questionsPerPlayerTouched = true;
      _questionsPerPlayer = value;
    });
  }

  void _syncQuestionsPerPlayer() {
    final maxValue = _maxQuestionsPerPlayer;
    final recommended = MatchSetupService.recommendedQuestionsPerPlayer(
      _players.length,
    );
    final nextValue = _questionsPerPlayerTouched
        ? _questionsPerPlayer.clamp(
            MatchSetup.minQuestionsPerPlayer,
            maxValue,
          )
        : recommended.clamp(MatchSetup.minQuestionsPerPlayer, maxValue);

    if (nextValue == _questionsPerPlayer) {
      return;
    }
    setState(() => _questionsPerPlayer = nextValue);
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
      roundCount: widget.roundCount,
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
  }

  String _messageFor(MatchSetupValidationError error) {
    return switch (error) {
      MatchSetupValidationError.emptyPlayerName => 'Name cannot be empty.',
      MatchSetupValidationError.duplicatePlayerName =>
        'Player names must be unique.',
      MatchSetupValidationError.tooManyPlayers =>
        'A match supports up to 9 players.',
      MatchSetupValidationError.tooFewPlayers => 'Add at least 3 players.',
      MatchSetupValidationError.invalidRoundCount => 'Round count is invalid.',
      MatchSetupValidationError.invalidQuestionsPerPlayer =>
        'Choose between 1 and 3 questions per player.',
      MatchSetupValidationError.insufficientPlayableWords =>
        'This category does not have enough playable words.',
      MatchSetupValidationError.insufficientQuestionsPerWord =>
        'This category does not have enough questions for that many players.',
    };
  }
}

class _QuestionsPerPlayerSelector extends StatelessWidget {
  const _QuestionsPerPlayerSelector({
    required this.value,
    required this.maxValue,
    required this.playerCount,
    required this.onChanged,
  });

  final int value;
  final int maxValue;
  final int playerCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final recommendation = playerCount > 0
        ? MatchSetupService.recommendedQuestionsPerPlayer(playerCount)
        : 2;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppRadius.borderLg,
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('PERGUNTAS POR JOGADOR', style: AppTypography.emphasis),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              'Quantas perguntas cada jogador responde nesta rodada?',
              style: AppTypography.body,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _recommendationText(playerCount, recommendation),
              style: AppTypography.bodySmall,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                for (var count = MatchSetup.minQuestionsPerPlayer;
                    count <= MatchSetup.maxQuestionsPerPlayer;
                    count += 1)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: count == MatchSetup.minQuestionsPerPlayer
                            ? 0
                            : AppSpacing.xs,
                      ),
                      child: _QuestionCountChip(
                        count: count,
                        selected: value == count,
                        enabled: count <= maxValue,
                        onTap: () => onChanged(count),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _recommendationText(int players, int recommended) {
    if (players < MatchSetup.minPlayers) {
      return 'Com 3–4 jogadores recomendamos $recommended; com 5 ou mais, 1 (até 3 se a categoria permitir).';
    }
    if (players <= 4) {
      return 'Recomendado para $players jogadores: $recommended perguntas por jogador.';
    }
    return 'Recomendado para $players jogadores: $recommended pergunta por jogador (até $maxValue nesta categoria).';
  }
}

class _QuestionCountChip extends StatelessWidget {
  const _QuestionCountChip({
    required this.count,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final int count;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = count == 1 ? '1 pergunta' : '$count perguntas';

    return Material(
      color: selected
          ? AppColors.primaryMain.withValues(alpha: 0.2)
          : AppColors.backgroundPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderMd,
        side: BorderSide(
          color: selected ? AppColors.primaryMain : AppColors.borderDefault,
        ),
      ),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: AppRadius.borderMd,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Text(
            label,
            style: AppTypography.label.copyWith(
              color: enabled
                  ? (selected ? AppColors.primaryMain : AppColors.textPrimary)
                  : AppColors.textDisabled,
            ),
            textAlign: TextAlign.center,
          ),
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
