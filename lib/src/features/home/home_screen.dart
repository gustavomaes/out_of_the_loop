import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_routes.dart';
import '../../app/discovery_shell.dart';
import '../../app/app_shell.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_brutalist_pill_button.dart';
import '../../shared/widgets/otl_home_backdrop.dart';
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
  static const _heroToActionsGap = 64.0;
  static const _actionsGap = 24.0;

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Semantics(
                      header: true,
                      label: l10n.appTitle,
                      child: const HomeHeroTitle(),
                    ),
                    const SizedBox(height: _heroToActionsGap),
                    OtlBrutalistPillButton(
                      label: l10n.startGame,
                      icon: Icons.play_arrow,
                      borderRadius: 0,
                      backgroundColor: BrutalistColors.lime,
                      foregroundColor: BrutalistColors.homePrimaryButtonText,
                      onPressed:
                          onStartGame ??
                          () => context.goDiscoveryTab(AppRoutes.categories),
                    ),
                    const SizedBox(height: _actionsGap),
                    OtlBrutalistPillButton(
                      label: l10n.howToPlay,
                      icon: Icons.help_outline,
                      borderRadius: 0,
                      backgroundColor: BrutalistColors.homeSecondaryButton,
                      foregroundColor: BrutalistColors.cardText,
                      onPressed:
                          onHowToPlay ?? () => context.push(AppRoutes.howToPlay),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
