import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_brutalist_pill_button.dart';
import '../../shared/widgets/otl_home_backdrop.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({this.onStartGame, this.onHowToPlay, super.key});

  final VoidCallback? onStartGame;
  final VoidCallback? onHowToPlay;

  static const _appNameLineOne = 'OUT OF THE';
  static const _appNameLineTwo = 'LOOP';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BrutalistScreenTheme.wrap(
      context,
      AppShell(
        routeName: AppRoutes.home,
        title: 'OUT OF THE LOOP',
        appBar: PreferredSize(
          preferredSize: Size.zero,
          child: SizedBox.shrink(),
        ),
        bodyPadding: EdgeInsets.zero,
        child: OtlHomeBackdrop(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _HomeHeroTitle(),
                    const SizedBox(height: 64),
                    OtlBrutalistPillButton(
                      label: l10n.startGame,
                      icon: Icons.play_arrow,
                      backgroundColor: BrutalistColors.lime,
                      foregroundColor: BrutalistColors.homePrimaryButtonText,
                      onPressed:
                          onStartGame ??
                          () => Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.categories),
                    ),
                    const SizedBox(height: 24),
                    OtlBrutalistPillButton(
                      label: l10n.howToPlay,
                      icon: Icons.help_outline,
                      backgroundColor: BrutalistColors.homeSecondaryButton,
                      foregroundColor: BrutalistColors.cardText,
                      onPressed:
                          onHowToPlay ??
                          () => Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.howToPlay),
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

class _HomeHeroTitle extends StatelessWidget {
  const _HomeHeroTitle();

  TextStyle _lineStyle(Color color) =>
      DisplayTypography.rubikHomeTitle(color: color);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(4, 4),
          child: Column(
            children: [
              Text(
                HomeScreen._appNameLineOne,
                style: _lineStyle(Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                HomeScreen._appNameLineTwo,
                style: _lineStyle(Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              HomeScreen._appNameLineOne,
              style: _lineStyle(BrutalistColors.lime),
              textAlign: TextAlign.center,
            ),
            Text(
              HomeScreen._appNameLineTwo,
              style: _lineStyle(BrutalistColors.lime),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
