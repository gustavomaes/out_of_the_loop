import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

class QuestionRoundScreen extends StatefulWidget {
  const QuestionRoundScreen({
    required this.players,
    required this.questionTurns,
    this.language = SupportedLanguage.ptBr,
    this.timerSettings = const TimerSettings(),
    this.remainingSeconds,
    this.onComplete,
    super.key,
  });

  final List<Player> players;
  final List<QuestionTurn> questionTurns;
  final SupportedLanguage language;
  final TimerSettings timerSettings;
  final int? remainingSeconds;
  final VoidCallback? onComplete;

  @override
  State<QuestionRoundScreen> createState() => _QuestionRoundScreenState();
}

class _QuestionRoundScreenState extends State<QuestionRoundScreen> {
  var _turnIndex = 0;
  var _awaitingNextQuestion = false;

  bool get _isLastTurn => _turnIndex == widget.questionTurns.length - 1;

  QuestionTurn get _currentTurn => widget.questionTurns[_turnIndex];

  Player get _currentPlayer => widget.players.firstWhere(
    (player) => player.id == _currentTurn.playerId,
  );

  @override
  Widget build(BuildContext context) {
    final remainingSeconds =
        widget.remainingSeconds ?? widget.timerSettings.durationSeconds;
    final timerExpired = widget.timerSettings.enabled && remainingSeconds == 0;

    return AppShell(
      routeName: AppRoutes.gameQuestions,
      title: 'Question Round',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'QUESTION ${_turnIndex + 1} OF ${widget.questionTurns.length}',
            style: AppTypography.emphasis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: AnimatedSwitcher(
              duration: AppDurations.normal,
              switchInCurve: AppCurves.defaultCurve,
              switchOutCurve: AppCurves.defaultCurve,
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0.12, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: AppCurves.defaultCurve,
                  ),
                );

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  ),
                );
              },
              child: _QuestionTurnCard(
                key: ValueKey('turn-$_turnIndex'),
                player: _currentPlayer,
                question: _currentTurn.question,
                language: widget.language,
                answered: _awaitingNextQuestion,
              ),
            ),
          ),
          if (widget.timerSettings.enabled) ...[
            Center(
              child: CircularTimer(
                remainingSeconds: remainingSeconds,
                totalSeconds: widget.timerSettings.durationSeconds,
              ),
            ),
            if (timerExpired) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Time is up. Finish this answer when ready.',
                style: AppTypography.label,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
          ],
          OtlButton.primary(
            label: _primaryButtonLabel,
            onPressed: _onPrimaryPressed,
          ),
        ],
      ),
    );
  }

  String get _primaryButtonLabel {
    if (_awaitingNextQuestion) {
      return _isLastTurn ? 'GO TO VOTING' : 'NEXT QUESTION';
    }
    return 'DONE ANSWERING';
  }

  void _onPrimaryPressed() {
    if (!_awaitingNextQuestion) {
      setState(() => _awaitingNextQuestion = true);
      return;
    }

    if (_isLastTurn) {
      widget.onComplete?.call();
      return;
    }

    setState(() {
      _turnIndex += 1;
      _awaitingNextQuestion = false;
    });
  }
}

class _QuestionTurnCard extends StatelessWidget {
  const _QuestionTurnCard({
    required this.player,
    required this.question,
    required this.language,
    required this.answered,
    super.key,
  });

  final Player player;
  final Question question;
  final SupportedLanguage language;
  final bool answered;

  @override
  Widget build(BuildContext context) {
    return OtlCard(
      selected: true,
      accented: answered,
      accentColor: AppColors.secondaryMain,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlayerAvatar(name: player.name, seed: player.avatarSeed),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${player.name} answers',
            style: AppTypography.h2.copyWith(color: AppColors.primaryMain),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            question.text.valueFor(language),
            style: AppTypography.h3,
            textAlign: TextAlign.center,
          ),
          if (answered) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Answer recorded. Ready for the next turn.',
              style: AppTypography.label,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
