import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../shared/widgets/otl_party_backdrop.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({this.onStartGame, this.onHowToPlay, super.key});

  final VoidCallback? onStartGame;
  final VoidCallback? onHowToPlay;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      routeName: AppRoutes.home,
      title: 'OUT OF THE LOOP',
      child: OtlPartyBackdrop(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'OUT OF THE LOOP',
                    style: AppTypography.h1.copyWith(
                      letterSpacing: 2,
                      shadows: const [
                        Shadow(
                          color: Color(0x99C8FF2E),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'A party game of secrets, clues, and suspicious friends.',
                    style: AppTypography.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.x3l),
                  OtlButton.primary(
                    label: 'START GAME',
                    onPressed:
                        onStartGame ??
                        () => Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.categories),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  OtlButton.outline(
                    label: 'HOW TO PLAY',
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
    );
  }
}
