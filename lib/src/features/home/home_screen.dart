import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_routes.dart';
import '../../app/discovery_shell.dart';
import '../../app/app_shell.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_brutalist_pill_button.dart';
import '../../shared/widgets/otl_home_backdrop.dart';
import '../../shared/widgets/otl_neon_action.dart';
import '../../theme/theme.dart';
import 'widgets/home_hero_title.dart';

/// Brand lockup — not localized (see [AppLocalizations.appTitle] for semantics).
abstract final class HomeBrand {
  static const lineOne = 'OUT OF THE';
  static const lineTwo = 'LOOP';
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({this.onStartGame, this.onHowToPlay, super.key});

  final VoidCallback? onStartGame;
  final VoidCallback? onHowToPlay;

  static const _contentMaxWidth = 448.0;
  static const _horizontalPadding = 20.0;
  static const _heroToActionsGap = 24.0;
  static const _actionsGap = 12.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BrutalistScreenTheme.wrap(
      context,
      AppShell(
        routeName: AppRoutes.home,
        title: '${HomeBrand.lineOne} ${HomeBrand.lineTwo}',
        appBar: const PreferredSize(
          preferredSize: Size.zero,
          child: SizedBox.shrink(),
        ),
        bodyPadding: EdgeInsets.zero,
        child: OtlHomeBackdrop(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _contentMaxWidth),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: _horizontalPadding,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          Semantics(
                            header: true,
                            label: l10n.appTitle,
                            child: const HomeHeroTitle(),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.homeTagline,
                            style: DisplayTypography.plusJakartaBody(
                              color: BrutalistColors.sectionLabel,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: _heroToActionsGap),
                          const _SecretCards(),
                          const SizedBox(height: 32),
                          OtlBrutalistPillButton(
                            label: l10n.startGame,
                            icon: Icons.arrow_forward,
                            backgroundColor: BrutalistColors.lime,
                            foregroundColor: BrutalistColors.limeText,
                            onPressed:
                                onStartGame ??
                                () => context.goDiscoveryTab(
                                  AppRoutes.categories,
                                ),
                          ),
                          const SizedBox(height: _actionsGap),
                          OtlNeonAction(
                            label: l10n.howToPlay,
                            icon: Icons.help_outline,
                            primary: false,
                            onPressed:
                                onHowToPlay ??
                                () => context.push(AppRoutes.howToPlay),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SecretCards extends StatelessWidget {
  const _SecretCards();
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < 3; i++)
            Transform.rotate(
              angle: (i - 1) * 0.14,
              child: Container(
                width: 78,
                height: i == 1 ? 128 : 106,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: i == 1
                      ? BrutalistColors.lime
                      : BrutalistColors.cardBackground,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: i == 1
                        ? BrutalistColors.lime
                        : BrutalistColors.headerBorder,
                  ),
                ),
                child: Icon(
                  i == 1
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 36,
                  color: i == 1
                      ? BrutalistColors.limeText
                      : BrutalistColors.sectionLabel,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
