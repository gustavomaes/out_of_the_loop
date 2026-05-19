import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'brutalist_count_chip.dart';
import 'match_setup_section_card.dart';

class RoundCountSelector extends StatelessWidget {
  const RoundCountSelector({
    required this.l10n,
    required this.value,
    required this.maxValue,
    required this.onChanged,
    super.key,
  });

  final AppLocalizations l10n;
  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return MatchSetupSectionCard(
      icon: Icons.layers_outlined,
      sectionLabel: l10n.matchSetupRoundsSection,
      description: l10n.matchSetupRoundsDescription,
      recommendation: l10n.matchSetupRoundsRecommended(
        MatchSetup.recommendedRoundCount,
      ),
      valueLabel: l10n.matchSetupRoundsValue(value),
      child: Row(
        children: [
          for (
            var count = MatchSetup.minRoundCount;
            count <= MatchSetup.maxRoundCount;
            count += 1
          )
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: count == MatchSetup.minRoundCount ? 0 : 8,
                ),
                child: BrutalistCountChip(
                  key: Key('round_count_$count'),
                  label: '$count',
                  selected: value == count,
                  enabled: count <= maxValue,
                  onTap: () => onChanged(count),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
