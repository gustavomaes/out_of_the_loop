import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_home_backdrop.dart';
import '../../shared/widgets/otl_neon_action.dart';
import '../../theme/theme.dart';

/// A safe practice card: this screen never reads or changes a real match.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({required this.onComplete, super.key});

  final Future<void> Function(bool skipped) onComplete;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;
  bool _revealed = false;
  bool _saving = false;

  Future<void> _finish(bool skipped) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await widget.onComplete(skipped);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.onboardingSaveError),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final titles = [
      l10n.onboardingSecretTitle,
      l10n.onboardingPassTitle,
      l10n.onboardingVoteTitle,
    ];
    final bodies = [
      l10n.onboardingSecretBody,
      l10n.onboardingPassBody,
      l10n.onboardingVoteBody,
    ];
    return BrutalistScreenTheme.wrap(
      context,
      PopScope(
        canPop: _step == 0 && !_saving,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop && !_saving && _step > 0) {
            setState(() => _step--);
          }
        },
        child: Scaffold(
          backgroundColor: BrutalistColors.screenBackground,
          body: OtlHomeBackdrop(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        if (_step > 0)
                          IconButton(
                            tooltip: MaterialLocalizations.of(
                              context,
                            ).backButtonTooltip,
                            onPressed: _saving
                                ? null
                                : () => setState(() => _step--),
                            icon: const Icon(Icons.arrow_back),
                          ),
                        const Spacer(),
                        TextButton(
                          onPressed: _saving ? null : () => _finish(true),
                          child: Text(l10n.onboardingSkip),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: SingleChildScrollView(
                          key: ValueKey(_step),
                          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                l10n.onboardingStep(_step + 1),
                                textAlign: TextAlign.center,
                                style: DisplayTypography.plusJakartaBody(
                                  color: BrutalistColors.lime,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 28),
                              if (_step == 0)
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    for (var i = 0; i < 3; i++)
                                      _DemoCard(
                                        label: i == 2
                                            ? l10n.onboardingOut
                                            : l10n.onboardingWord,
                                        icon: i == 2
                                            ? Icons.question_mark_rounded
                                            : Icons.visibility_outlined,
                                        color: i == 2
                                            ? BrutalistColors.playerCardPink
                                            : BrutalistColors.lime,
                                      ),
                                  ],
                                )
                              else if (_step == 1)
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.phonelink_ring_rounded,
                                      size: 40,
                                      color: BrutalistColors.howToPlayCyan,
                                    ),
                                    const SizedBox(height: 16),
                                    Semantics(
                                      button: true,
                                      label: _revealed
                                          ? l10n.onboardingHide
                                          : l10n.onboardingReveal,
                                      child: InkWell(
                                        key: const Key('onboarding-demo'),
                                        borderRadius: BorderRadius.circular(24),
                                        onTap: () => setState(
                                          () => _revealed = !_revealed,
                                        ),
                                        child: _DemoCard(
                                          label: _revealed
                                              ? l10n.onboardingWord
                                              : null,
                                          icon: _revealed
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: _revealed
                                              ? BrutalistColors.lime
                                              : BrutalistColors
                                                    .playerCardYellow,
                                          width: 190,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      _revealed
                                          ? l10n.onboardingHide
                                          : l10n.onboardingReveal,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              else
                                _DemoCard(
                                  label: l10n.onboardingVoteLabel,
                                  icon: Icons.how_to_vote_outlined,
                                  color: BrutalistColors.playerCardPink,
                                ),
                              const SizedBox(height: 32),
                              Text(
                                titles[_step],
                                textAlign: TextAlign.center,
                                style: DisplayTypography.rubikTitle(
                                  color: BrutalistColors.cardText,
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                bodies[_step],
                                textAlign: TextAlign.center,
                                style: DisplayTypography.plusJakartaBody(
                                  color: BrutalistColors.sectionLabel,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  OtlNeonFooter(
                    child: OtlNeonAction(
                      label: _step == 2
                          ? l10n.onboardingStart
                          : l10n.onboardingNext,
                      icon: Icons.arrow_forward,
                      onPressed: _saving
                          ? null
                          : () {
                              if (_step == 2) {
                                _finish(false);
                              } else {
                                setState(() {
                                  _step++;
                                  _revealed = false;
                                });
                              }
                            },
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

class _DemoCard extends StatelessWidget {
  const _DemoCard({
    this.label,
    required this.icon,
    required this.color,
    this.width,
  });
  final String? label;
  final IconData icon;
  final Color color;
  final double? width;

  @override
  Widget build(BuildContext context) => Container(
    width: width ?? 130,
    constraints: const BoxConstraints(minHeight: 150),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(color: color.withValues(alpha: 0.16), blurRadius: 24),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 36, color: BrutalistColors.limeText),
        if (label != null) ...[
          const SizedBox(height: 16),
          Text(
            label!,
            textAlign: TextAlign.center,
            style: DisplayTypography.plusJakartaBody(
              color: BrutalistColors.limeText,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ],
    ),
  );
}
