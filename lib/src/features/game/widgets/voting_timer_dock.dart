import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

class VotingTimerDock extends StatelessWidget {
  const VotingTimerDock({
    required this.timeToVoteLabel,
    required this.secondsLabel,
    required this.remainingSeconds,
    required this.totalSeconds,
    super.key,
  });

  final String timeToVoteLabel;
  final String secondsLabel;
  final int remainingSeconds;
  final int totalSeconds;

  @override
  Widget build(BuildContext context) {
    final progress = totalSeconds == 0
        ? 0.0
        : (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: BrutalistColors.homeSecondaryButton,
        border: const Border(top: BorderSide(color: Colors.black, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            offset: const Offset(0, -8),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 512),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: BrutalistColors.sectionLabel,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            timeToVoteLabel,
                            style: DisplayTypography.spaceGroteskSectionLabel(
                              color: BrutalistColors.sectionLabel,
                            ),
                          ),
                        ],
                      ),
                      OtlShadowedText(
                        text: secondsLabel,
                        style: DisplayTypography.rubikVotingTimerSeconds(
                          color: BrutalistColors.votingAtmosphereAccent,
                        ),
                        shadowOffset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 16,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: BrutalistColors.screenBackground,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: Colors.black, width: 3),
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
                                decoration: const BoxDecoration(
                                  color: BrutalistColors.votingAtmosphereAccent,
                                ),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 4,
                                    color: Colors.white.withValues(alpha: 0.3),
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
                                    Colors.black.withValues(alpha: 0.5),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
