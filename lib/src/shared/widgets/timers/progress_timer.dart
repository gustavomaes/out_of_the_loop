import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class ProgressTimer extends StatelessWidget {
  const ProgressTimer({
    required this.remainingSeconds,
    required this.totalSeconds,
    this.height = 4,
    super.key,
  });

  final int remainingSeconds;
  final int totalSeconds;
  final double height;

  bool get isWarning => remainingSeconds <= 5;

  double get progress {
    if (totalSeconds <= 0) {
      return 0;
    }
    return (remainingSeconds / totalSeconds).clamp(0, 1).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Timer progress',
      value: '${(progress * 100).round()} percent',
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: AppRadius.borderFull,
          boxShadow: isWarning ? AppShadows.magentaGlow : AppShadows.glow,
        ),
        child: ClipRRect(
          borderRadius: AppRadius.borderFull,
          child: SizedBox(
            height: height,
            child: LinearProgressIndicator(
              key: const Key('otl_progress_timer_indicator'),
              value: progress,
              backgroundColor: AppColors.backgroundTertiary,
              color: isWarning ? AppColors.error : AppColors.primaryMain,
              minHeight: height,
            ),
          ),
        ),
      ),
    );
  }
}
