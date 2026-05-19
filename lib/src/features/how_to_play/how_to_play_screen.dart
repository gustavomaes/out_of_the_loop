import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  static const _lime = BrutalistColors.lime;
  static const _limeText = BrutalistColors.limeText;
  static const _yellow = Color(0xFFFFE170);
  static const _yellowText = Color(0xFF221B00);
  static const _magenta = Color(0xFFFF24E4);
  static const _cyan = Color(0xFF00E5FF);

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
                  _RuleCard(
                    backgroundColor: _lime,
                    foregroundColor: _limeText,
                    icon: Icons.visibility_off_outlined,
                    title: l10n.howToPlaySecretTitle,
                    bodySpans: [
                      TextSpan(text: l10n.howToPlaySecretBodyBefore),
                      TextSpan(
                        text: l10n.howToPlaySecretBodyHighlight,
                        style: DisplayTypography.plusJakartaBody(
                          color: _limeText,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _RuleCard(
                    backgroundColor: _yellow,
                    foregroundColor: _yellowText,
                    icon: Icons.chat_bubble_outline,
                    title: l10n.howToPlayQuestionTitle,
                    bodySpans: [
                      TextSpan(text: l10n.howToPlayQuestionBodyBefore),
                      TextSpan(
                        text: l10n.howToPlayQuestionBodyEmphasis,
                        style: DisplayTypography.plusJakartaBody(
                          color: _yellowText,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _RuleCard(
                    backgroundColor: _magenta,
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
                  _RuleCard(
                    backgroundColor: _cyan,
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
                  _KaPowBanner(label: l10n.howToPlayKapow),
                  const SizedBox(height: 32),
                ],
        ),
      ),
    );
  }
}

class _RuleCard extends StatelessWidget {
  const _RuleCard({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.title,
    required this.bodySpans,
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

class _KaPowBanner extends StatelessWidget {
  const _KaPowBanner({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 6,
      padding: const EdgeInsets.all(4),
      height: 160,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.4,
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix(<double>[
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
                child: Image.asset(
                  'assets/images/how_to_play_party.png',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.25),
                ),
              ),
            ),
            Center(
              child: OtlBrutalistSurface(
                backgroundColor: BrutalistColors.lime,
                shadowOffset: 6,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Text(
                  label,
                  style: DisplayTypography.rubikTitle(
                    color: Colors.black,
                    fontSize: 48,
                    height: 52 / 48,
                    letterSpacing: -0.96,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
