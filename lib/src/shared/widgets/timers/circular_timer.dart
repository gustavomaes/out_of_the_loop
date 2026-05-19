import 'package:flutter/material.dart';

import '../../../theme/app_tokens.dart';

class CircularTimer extends StatelessWidget {
  const CircularTimer({
    required this.remainingSeconds,
    required this.totalSeconds,
    this.size = 88,
    super.key,
  });

  final int remainingSeconds;
  final int totalSeconds;
  final double size;

  bool get isWarning => remainingSeconds <= 5;

  double get progress {
    if (totalSeconds <= 0) {
      return 0;
    }
    return (remainingSeconds / totalSeconds).clamp(0, 1).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final color = isWarning ? AppColors.error : AppColors.primaryMain;

    return Semantics(
      label: 'Timer: $remainingSeconds seconds remaining',
      value: '$remainingSeconds',
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderDefault),
                boxShadow: isWarning ? AppShadows.magentaGlow : AppShadows.glow,
              ),
            ),
            CircularProgressIndicator(
              key: const Key('otl_circular_timer_indicator'),
              value: progress,
              strokeWidth: 6,
              backgroundColor: AppColors.backgroundTertiary,
              color: color,
              strokeCap: StrokeCap.round,
            ),
            Text(
              '$remainingSeconds',
              style: AppTypography.timer.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
