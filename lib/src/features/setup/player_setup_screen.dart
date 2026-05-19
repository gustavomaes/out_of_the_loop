import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../domain/services/match_setup_service.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

typedef PlayerSetupStartCallback =
    void Function(List<Player> players, int roundCount, int questionsPerPlayer);

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({
    required this.roundCount,
    required this.questionsPerPlayer,
    this.categoryWords,
    this.onStart,
    MatchSetupService? setupService,
    super.key,
  }) : setupService = setupService ?? const MatchSetupService();

  final int roundCount;
  final int questionsPerPlayer;
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
    final validation = _validation;
    final canStart = validation.canStart;

    return AppShell(
      routeName: AppRoutes.players,
      title: 'Players',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
          ),
          Text(
            '${_players.length}/9 players ready',
            style: AppTypography.label,
            textAlign: TextAlign.center,
          ),
          if (_players.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              '$_roundCount ${_roundCount == 1 ? 'rodada' : 'rodadas'} na partida',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${_players.length * _questionsPerPlayer} perguntas por rodada',
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
                        _roundCount,
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

  String _messageFor(MatchSetupValidationError error) {
    return switch (error) {
      MatchSetupValidationError.emptyPlayerName => 'Name cannot be empty.',
      MatchSetupValidationError.duplicatePlayerName =>
        'Player names must be unique.',
      MatchSetupValidationError.tooManyPlayers =>
        'A match supports up to 9 players.',
      MatchSetupValidationError.tooFewPlayers => 'Add at least 3 players.',
      MatchSetupValidationError.invalidRoundCount =>
        'Número de rodadas inválido.',
      MatchSetupValidationError.invalidQuestionsPerPlayer =>
        'Choose between 1 and 3 questions per player.',
      MatchSetupValidationError.insufficientPlayableWords =>
        'Esta categoria não tem palavras suficientes para tantas rodadas.',
      MatchSetupValidationError.insufficientQuestionsPerWord =>
        'This category does not have enough questions for that many players.',
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
