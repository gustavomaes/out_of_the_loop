import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../domain/services/match_setup_service.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'brutalist_count_chip.dart';
import 'match_setup_section_card.dart';

class QuestionsPerPlayerSelector extends StatelessWidget {
  const QuestionsPerPlayerSelector({
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
    final recommended = MatchSetupService.recommendedQuestionsPerPlayer(3);

    return MatchSetupSectionCard(
      icon: Icons.quiz_outlined,
      sectionLabel: l10n.matchSetupQuestionsSection,
      description: l10n.matchSetupQuestionsDescription,
      recommendation: l10n.matchSetupQuestionsRecommendation(recommended),
      valueLabel: l10n.matchSetupQuestionCountChip(value),
      child: Row(
        children: [
          for (
            var count = MatchSetup.minQuestionsPerPlayer;
            count <= MatchSetup.maxQuestionsPerPlayer;
            count += 1
          )
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: count == MatchSetup.minQuestionsPerPlayer ? 0 : 8,
                ),
                child: BrutalistCountChip(
                  key: Key('question_count_$count'),
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
