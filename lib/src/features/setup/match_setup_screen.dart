import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../domain/services/match_setup_service.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

typedef MatchSetupContinueCallback =
    void Function(int roundCount, int questionsPerPlayer);

class MatchSetupScreen extends StatefulWidget {
  const MatchSetupScreen({
    this.categoryWords,
    this.onContinue,
    MatchSetupService? setupService,
    super.key,
  }) : setupService = setupService ?? const MatchSetupService();

  final List<SecretWord>? categoryWords;
  final MatchSetupContinueCallback? onContinue;
  final MatchSetupService setupService;

  @override
  State<MatchSetupScreen> createState() => _MatchSetupScreenState();
}

class _MatchSetupScreenState extends State<MatchSetupScreen> {
  var _roundCount = MatchSetup.recommendedRoundCount;
  var _roundCountTouched = false;
  var _questionsPerPlayer = MatchSetupService.recommendedQuestionsPerPlayer(0);
  var _questionsPerPlayerTouched = false;

  List<SecretWord> get _categoryWords =>
      widget.categoryWords ?? _defaultPlayableWords;

  int get _maxQuestionsPerPlayer => MatchSetupService.maxQuestionsPerPlayerFor(
    playerCount: MatchSetup.minPlayers,
    categoryWords: _categoryWords,
  );

  int get _maxRoundCount => MatchSetupService.maxRoundCountFor(
    playerCount: MatchSetup.minPlayers,
    questionsPerPlayer: _questionsPerPlayer,
    categoryWords: _categoryWords,
  );

  bool get _canContinue =>
      _roundCount >= MatchSetup.minRoundCount &&
      _roundCount <= _maxRoundCount &&
      _questionsPerPlayer >= MatchSetup.minQuestionsPerPlayer &&
      _questionsPerPlayer <= _maxQuestionsPerPlayer;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      routeName: AppRoutes.matchSetup,
      title: 'Match Setup',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('CONFIGURAR PARTIDA', style: AppTypography.emphasis),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'Defina as regras antes de cadastrar os jogadores.',
                    style: AppTypography.h2,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _QuestionsPerPlayerSelector(
                    value: _questionsPerPlayer,
                    maxValue: _maxQuestionsPerPlayer,
                    playerCount: 0,
                    onChanged: _setQuestionsPerPlayer,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _RoundCountSelector(
                    value: _roundCount,
                    maxValue: _maxRoundCount,
                    onChanged: _setRoundCount,
                  ),
                ],
              ),
            ),
          ),
          Text(
            '$_roundCount ${_roundCount == 1 ? 'rodada' : 'rodadas'} · '
            '$_questionsPerPlayer '
            '${_questionsPerPlayer == 1 ? 'pergunta' : 'perguntas'} por jogador',
            style: AppTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: AppRadius.borderLg,
              border: Border.all(color: AppColors.borderDefault),
              boxShadow: _canContinue ? AppShadows.glow : AppShadows.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: OtlButton.primary(
                label: 'CONTINUE',
                onPressed: _canContinue
                    ? () => widget.onContinue?.call(
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

  void _setRoundCount(int value) {
    setState(() {
      _roundCountTouched = true;
      _roundCount = value;
    });
  }

  void _setQuestionsPerPlayer(int value) {
    setState(() {
      _questionsPerPlayerTouched = true;
      _questionsPerPlayer = value;
    });
    _syncRoundCount();
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
}

class _RoundCountSelector extends StatelessWidget {
  const _RoundCountSelector({
    required this.value,
    required this.maxValue,
    required this.onChanged,
  });

  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
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
            Text('RODADAS NA PARTIDA', style: AppTypography.emphasis),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              'Quantas rodadas esta partida terá?',
              style: AppTypography.body,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Recomendado: ${MatchSetup.recommendedRoundCount} rodadas.',
              style: AppTypography.bodySmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('Rodadas: $value', style: AppTypography.body),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                for (
                  var count = MatchSetup.minRoundCount;
                  count <= MatchSetup.maxRoundCount;
                  count += 1
                )
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: count == MatchSetup.minRoundCount
                            ? 0
                            : AppSpacing.xs,
                      ),
                      child: _RoundCountChip(
                        key: Key('round_count_$count'),
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
}

class _RoundCountChip extends StatelessWidget {
  const _RoundCountChip({
    super.key,
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
            '$count',
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
                for (
                  var count = MatchSetup.minQuestionsPerPlayer;
                  count <= MatchSetup.maxQuestionsPerPlayer;
                  count += 1
                )
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
