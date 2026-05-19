import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../domain/services/match_setup_service.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

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
  final ValueChanged<List<Player>>? onStart;
  final MatchSetupService setupService;

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  final _controller = TextEditingController();
  final _players = <Player>[];
  MatchSetupValidationError? _latestError;

  List<SecretWord> get _categoryWords =>
      widget.categoryWords ?? _defaultPlayableWords;

  MatchSetupValidationResult get _validation => widget.setupService.validate(
    players: _players,
    roundCount: widget.roundCount,
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
            Text(
              _messageFor(_latestError!),
              key: const Key('player_setup_error'),
              style: AppTypography.bodySmall.copyWith(color: AppColors.error),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: ListView.separated(
              itemCount: _players.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final player = _players[index];
                return OtlCard(
                  child: Row(
                    children: [
                      PlayerAvatar(name: player.name, seed: player.avatarSeed),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          player.name,
                          style: AppTypography.body.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Text(
            '${_players.length}/9 players ready',
            style: AppTypography.label,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          OtlButton.primary(
            label: 'START MATCH',
            onPressed: canStart ? () => widget.onStart?.call(_players) : null,
          ),
        ],
      ),
    );
  }

  void _addPlayer() {
    final name = _controller.text.trim();
    final candidate = Player(
      id: 'player-${_players.length + 1}',
      name: name,
      avatarSeed: name,
    );
    final nextPlayers = [..._players, candidate];
    final validation = widget.setupService.validate(
      players: nextPlayers,
      roundCount: widget.roundCount,
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
      _players.add(candidate);
      _latestError = null;
      _controller.clear();
    });
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
      MatchSetupValidationError.insufficientPlayableWords =>
        'This category does not have enough playable words.',
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
