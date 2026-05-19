import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/how_to_play_kapow_banner.dart';
import 'widgets/how_to_play_rule_card.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BrutalistScreenTheme.wrap(
      context,
      AppShell(
        routeName: AppRoutes.howToPlay,
        title: l10n.howToPlay,
        appBar: OtlBrutalistAppBar(title: l10n.howToPlayScreenTitle),
        bodyPadding: EdgeInsets.zero,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            HowToPlayRuleCard(
              backgroundColor: BrutalistColors.lime,
              foregroundColor: BrutalistColors.limeText,
              icon: Icons.visibility_off_outlined,
              title: l10n.howToPlaySecretTitle,
              bodySpans: [
                TextSpan(text: l10n.howToPlaySecretBodyBefore),
                TextSpan(
                  text: l10n.howToPlaySecretBodyHighlight,
                  style: DisplayTypography.plusJakartaBody(
                    color: BrutalistColors.limeText,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            HowToPlayRuleCard(
              backgroundColor: BrutalistColors.playerCardYellow,
              foregroundColor: BrutalistColors.howToPlayYellowText,
              icon: Icons.chat_bubble_outline,
              title: l10n.howToPlayQuestionTitle,
              bodySpans: [
                TextSpan(text: l10n.howToPlayQuestionBodyBefore),
                TextSpan(
                  text: l10n.howToPlayQuestionBodyEmphasis,
                  style: DisplayTypography.plusJakartaBody(
                    color: BrutalistColors.howToPlayYellowText,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            HowToPlayRuleCard(
              backgroundColor: BrutalistColors.playerCardPink,
              foregroundColor: Colors.white,
              icon: Icons.how_to_vote_outlined,
              title: l10n.howToPlayVoteTitle,
              bodySpans: [
                TextSpan(text: l10n.howToPlayVoteBodyBefore),
                TextSpan(
                  text: l10n.howToPlayVoteBodyHighlight,
                  style: DisplayTypography.plusJakartaBody(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: l10n.howToPlayVoteBodyAfter),
              ],
            ),
            const SizedBox(height: 16),
            HowToPlayRuleCard(
              backgroundColor: BrutalistColors.howToPlayCyan,
              foregroundColor: Colors.black,
              icon: Icons.emoji_events_outlined,
              title: l10n.howToPlayOutcomeTitle,
              bodySpans: [
                TextSpan(text: l10n.howToPlayOutcomeBodyBefore),
                TextSpan(
                  text: l10n.howToPlayOutcomeBodyHighlight,
                  style: DisplayTypography.plusJakartaBody(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: l10n.howToPlayOutcomeBodyAfter),
              ],
            ),
            const SizedBox(height: 40),
            HowToPlayKapowBanner(label: l10n.howToPlayKapow),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
