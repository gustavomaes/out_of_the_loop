import 'package:flutter/material.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../theme/theme.dart';

class MatchSetupHeader extends StatelessWidget {
  const MatchSetupHeader({required this.l10n, super.key});
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        l10n.matchSetupTitleLine1,
        style: DisplayTypography.rubikPlayerSetupTitle(
          color: BrutalistColors.cardText,
        ),
      ),
      Text(
        l10n.matchSetupTitleLine2,
        style: DisplayTypography.rubikPlayerSetupTitle(
          color: BrutalistColors.lime,
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: BrutalistColors.cardBackground,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          l10n.matchSetupRulesBadge,
          key: const Key('match_setup_rules_badge'),
          style: DisplayTypography.spaceGroteskMeta(
            color: BrutalistColors.sectionLabel,
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}
