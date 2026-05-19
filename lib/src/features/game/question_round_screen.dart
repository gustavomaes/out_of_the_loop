import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

class QuestionRoundScreen extends StatefulWidget {
  const QuestionRoundScreen({
    required this.players,
    required this.questions,
    this.language = SupportedLanguage.ptBr,
    this.timerSettings = const TimerSettings(),
    this.remainingSeconds,
    this.onComplete,
    super.key,
  });

  final List<Player> players;
  final List<Question> questions;
  final SupportedLanguage language;
  final TimerSettings timerSettings;
  final int? remainingSeconds;
  final VoidCallback? onComplete;

  @override
  State<QuestionRoundScreen> createState() => _QuestionRoundScreenState();
}

class _QuestionRoundScreenState extends State<QuestionRoundScreen> {
  var _questionIndex = 0;

  bool get _isLastQuestion => _questionIndex == widget.questions.length - 1;

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_questionIndex];
    final player = widget.players[_questionIndex % widget.players.length];
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
            'Question ${_questionIndex + 1} of ${widget.questions.length}',
            style: AppTypography.label,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          OtlCard(
            selected: true,
            child: Column(
              children: [
                Text('${player.name} answers', style: AppTypography.h2),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  question.text.valueFor(widget.language),
                  style: AppTypography.h3,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
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
            const SizedBox(height: AppSpacing.xl),
          ],
          const Spacer(),
          OtlButton.primary(
            label: _isLastQuestion ? 'GO TO VOTING' : 'DONE ANSWERING',
            onPressed: _advance,
          ),
        ],
      ),
    );
  }

  void _advance() {
    if (_isLastQuestion) {
      widget.onComplete?.call();
      return;
    }
    setState(() => _questionIndex += 1);
  }
}
