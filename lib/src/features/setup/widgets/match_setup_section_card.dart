import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

class MatchSetupSectionCard extends StatelessWidget {
  const MatchSetupSectionCard({
    required this.icon,
    required this.sectionLabel,
    required this.description,
    required this.recommendation,
    required this.valueLabel,
    required this.child,
    super.key,
  });

  final IconData icon;
  final String sectionLabel;
  final String description;
  final String recommendation;
  final String valueLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 4,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: BrutalistColors.lime, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  sectionLabel,
                  style: DisplayTypography.spaceGroteskSectionLabel(
                    color: BrutalistColors.lime,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: DisplayTypography.plusJakartaBody(
              color: BrutalistColors.cardText,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            recommendation,
            style: DisplayTypography.plusJakartaBody(
              color: BrutalistColors.sectionLabel,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            valueLabel,
            key: ValueKey('match_setup_value_$sectionLabel'),
            style: DisplayTypography.rubikSettingLabel(
              color: BrutalistColors.cardText,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
