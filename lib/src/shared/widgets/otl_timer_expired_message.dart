import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Timer-expired copy block used on question round and voting screens.
class OtlTimerExpiredMessage extends StatelessWidget {
  const OtlTimerExpiredMessage({
    required this.line1,
    required this.line2,
    this.style = OtlTimerExpiredMessageStyle.voting,
    super.key,
  });

  final String line1;
  final String line2;
  final OtlTimerExpiredMessageStyle style;

  TextStyle _lineStyle() {
    return switch (style) {
      OtlTimerExpiredMessageStyle.voting => DisplayTypography
          .plusJakartaVotingSubtitle(color: BrutalistColors.sectionLabel),
      OtlTimerExpiredMessageStyle.questionRound => DisplayTypography
          .plusJakartaBody(
            color: BrutalistColors.sectionLabel,
            fontSize: 16,
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final lineStyle = _lineStyle();
    return Column(
      children: [
        Text(line1, style: lineStyle, textAlign: TextAlign.center),
        Text(line2, style: lineStyle, textAlign: TextAlign.center),
      ],
    );
  }
}

/// Preserves per-screen typography from pre-consolidation private widgets.
enum OtlTimerExpiredMessageStyle { voting, questionRound }
