import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

/// Colored rule explainer card on the how-to-play screen.
class HowToPlayRuleCard extends StatelessWidget {
  const HowToPlayRuleCard({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.title,
    required this.bodySpans,
    super.key,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final String title;
  final List<InlineSpan> bodySpans;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = DisplayTypography.plusJakartaBody(color: foregroundColor);

    return OtlBrutalistSurface(
      backgroundColor: backgroundColor,
      shadowOffset: 6,
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: foregroundColor, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: DisplayTypography.rubikTitle(color: foregroundColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text.rich(TextSpan(style: bodyStyle, children: bodySpans)),
        ],
      ),
    );
  }
}
