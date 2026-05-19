import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class QuestionRoundTimer extends StatelessWidget {
  const QuestionRoundTimer({
    required this.timeRemainingLabel,
    required this.secondsLabel,
    required this.remainingSeconds,
    required this.totalSeconds,
    super.key,
  });

  final String timeRemainingLabel;
  final String secondsLabel;
  final int remainingSeconds;
  final int totalSeconds;

  @override
  Widget build(BuildContext context) {
    final progress = totalSeconds == 0
        ? 0.0
        : (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                timeRemainingLabel,
                style: DisplayTypography.spaceGroteskSectionLabel(
                  color: BrutalistColors.sectionLabel,
                ),
              ),
              Text(
                secondsLabel,
                style: DisplayTypography.spaceGroteskSectionLabel(
                  color: BrutalistColors.playerCardYellow,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 24,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: BrutalistColors.cardBackground,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: Colors.black, width: 4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: BrutalistColors.playerCardYellow,
                        border: const Border(
                          right: BorderSide(color: Colors.black, width: 4),
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
