import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
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
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'OUT OF THE LOOP',
                style: AppTypography.h1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'A party game of secrets, clues, and suspicious friends.',
                style: AppTypography.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.x2l),
              OtlCard(
                selected: true,
                child: Column(
                  children: [
                    const Icon(
                      Icons.visibility_off,
                      color: AppColors.secondaryMain,
                      size: 48,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Pass the phone, reveal your role, then find who is out.',
                      style: AppTypography.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              OtlButton.primary(
                label: 'START GAME',
                onPressed:
                    onStartGame ??
                    () => Navigator.of(context).pushNamed(AppRoutes.categories),
              ),
              const SizedBox(height: AppSpacing.md),
              OtlButton.outline(
                label: 'HOW TO PLAY',
                onPressed:
                    onHowToPlay ??
                    () => Navigator.of(context).pushNamed(AppRoutes.howToPlay),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
