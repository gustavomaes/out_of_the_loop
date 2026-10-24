import 'package:flutter/material.dart';
import '../../../shared/widgets/otl_brutalist_surface.dart';
import '../../../theme/theme.dart';

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
  Widget build(BuildContext context) => OtlBrutalistSurface(
    backgroundColor: BrutalistColors.cardBackground,
    shadowOffset: 0,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: backgroundColor, size: 28),
        const SizedBox(height: 16),
        Text(
          title,
          style: DisplayTypography.rubikTitle(
            color: BrutalistColors.cardText,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            style: DisplayTypography.plusJakartaBody(
              color: BrutalistColors.sectionLabel,
              fontSize: 16,
            ),
            children: bodySpans
                .map(
                  (span) => span is TextSpan
                      ? TextSpan(
                          text: span.text,
                          style: span.style?.copyWith(
                            color: BrutalistColors.cardText,
                          ),
                          children: span.children,
                        )
                      : span,
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}
