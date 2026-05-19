import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

void main() {
  group('App design tokens', () {
    test('expose representative colors from the design system', () {
      expect(AppColors.backgroundPrimary, const Color(0xFF070718));
      expect(AppColors.primaryMain, const Color(0xFFC8FF2E));
      expect(AppColors.secondaryMain, const Color(0xFFFF3DF2));
      expect(AppColors.overlayGlow, const Color(0x33C8FF2E));
      expect(AppColors.borderFocus, AppColors.primaryMain);
    });

    test('expose spacing, radius, shadow, and animation tokens', () {
      expect(AppSpacing.md, 16);
      expect(AppRadius.borderFull, BorderRadius.circular(40));
      expect(AppShadows.md.single.blurRadius, 12);
      expect(AppDurations.fast, const Duration(milliseconds: 150));
      expect(AppDurations.normal, const Duration(milliseconds: 300));
      expect(AppDurations.slow, const Duration(milliseconds: 500));
    });

    test('maps typography tokens to Flutter text styles', () {
      expect(AppTypography.h1.fontFamily, 'Poppins');
      expect(AppTypography.h1.fontSize, 32);
      expect(AppTypography.h1.fontWeight, FontWeight.w700);
      expect(AppTypography.timer.fontSize, 48);
      expect(AppTypography.emphasis.letterSpacing, 1);
    });
  });

  group('OutOfTheLoopTheme', () {
    test('uses dark scaffold and surface colors by default', () {
      final theme = OutOfTheLoopTheme.dark;

      expect(theme.scaffoldBackgroundColor, AppColors.backgroundPrimary);
      expect(theme.canvasColor, AppColors.backgroundPrimary);
      expect(theme.cardColor, AppColors.backgroundSecondary);
      expect(theme.scaffoldBackgroundColor, isNot(Colors.white));
      expect(theme.colorScheme.surface, isNot(Colors.white));
      expect(theme.colorScheme.onPrimary, AppColors.backgroundPrimary);
    });
  });
}
