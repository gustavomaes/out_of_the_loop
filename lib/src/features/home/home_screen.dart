import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_routes.dart';
import '../../app/discovery_shell.dart';
import '../../app/app_shell.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_brutalist_pill_button.dart';
import '../../shared/widgets/otl_home_backdrop.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

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
                      child: const _HomeHeroTitle(),
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

/// Figma node `2:16` — lime title with 4×4 black offset shadow.
class _HomeHeroTitle extends StatelessWidget {
  const _HomeHeroTitle();

  static const _shadowOffset = Offset(4, 4);
  static const _horizontalPadding = 43.5;

  TextStyle _lineStyle(Color color) =>
      DisplayTypography.rubikHomeTitle(color: color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Transform.translate(
            offset: _shadowOffset,
            child: _TitleLines(style: _lineStyle(Colors.black)),
          ),
          _TitleLines(style: _lineStyle(BrutalistColors.lime)),
        ],
      ),
    );
  }
}

class _TitleLines extends StatelessWidget {
  const _TitleLines({required this.style});

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          HomeBrand.lineOne,
          style: style,
          textAlign: TextAlign.center,
        ),
        Text(
          HomeBrand.lineTwo,
          style: style,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
