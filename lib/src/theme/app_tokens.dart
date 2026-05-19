import 'package:flutter/material.dart';

abstract final class AppColors {
  static const backgroundPrimary = Color(0xFF070718);
  static const backgroundSecondary = Color(0xFF12122E);
  static const backgroundTertiary = Color(0xFF1D1D43);

  static const primaryMain = Color(0xFFC8FF2E);
  static const primaryLight = Color(0xFFE2FF7A);
  static const primaryDark = Color(0xFF8FC71F);

  static const secondaryMain = Color(0xFFFF3DF2);
  static const secondaryLight = Color(0xFFFF78F7);
  static const secondaryDark = Color(0xFFC218B7);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFC8CCE5);
  static const textTertiary = Color(0xFF858AAF);
  static const textDisabled = Color(0xFF4E5273);

  static const success = Color(0xFF59E88B);
  static const error = Color(0xFFFF4D6D);
  static const warning = Color(0xFFFFC857);
  static const info = Color(0xFF5AA9FF);

  static const borderDefault = Color(0xFF30345F);
  static const borderStrong = Color(0xFF626993);
  static const borderFocus = Color(0xFFC8FF2E);

  static const overlayDark = Color(0x99000000);
  static const overlayGlow = Color(0x33C8FF2E);
  static const overlayGlowStrong = Color(0x66C8FF2E);
  static const overlayMagentaGlow = Color(0x33FF3DF2);
}

abstract final class AppSpacing {
  static const zero = 0.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const x2l = 48.0;
  static const x3l = 64.0;
}

abstract final class AppRadius {
  static const none = Radius.circular(0);
  static const sm = Radius.circular(8);
  static const md = Radius.circular(12);
  static const lg = Radius.circular(16);
  static const xl = Radius.circular(24);
  static const full = Radius.circular(40);
  static const circle = Radius.circular(9999);

  static const borderNone = BorderRadius.all(none);
  static const borderSm = BorderRadius.all(sm);
  static const borderMd = BorderRadius.all(md);
  static const borderLg = BorderRadius.all(lg);
  static const borderXl = BorderRadius.all(xl);
  static const borderFull = BorderRadius.all(full);
  static const borderCircle = BorderRadius.all(circle);
}

abstract final class AppShadows {
  static const none = <BoxShadow>[];

  static const sm = <BoxShadow>[
    BoxShadow(color: Color(0x33000000), offset: Offset(0, 2), blurRadius: 4),
  ];

  static const md = <BoxShadow>[
    BoxShadow(color: Color(0x4DC8FF2E), offset: Offset(0, 4), blurRadius: 12),
  ];

  static const lg = <BoxShadow>[
    BoxShadow(color: Color(0x66000000), offset: Offset(0, 8), blurRadius: 24),
  ];

  static const glow = <BoxShadow>[
    BoxShadow(color: Color(0x99C8FF2E), blurRadius: 12),
  ];

  static const magentaGlow = <BoxShadow>[
    BoxShadow(color: Color(0x80FF3DF2), blurRadius: 12),
  ];
}

abstract final class AppDurations {
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);
}

abstract final class AppCurves {
  static const defaultCurve = Curves.easeInOut;
  static const bounce = Curves.easeOutBack;
}

abstract final class AppTypography {
  static const primaryFontFamily = 'Poppins';
  static const fallbackFontFamily = <String>['Inter'];

  static const h1 = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 32,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const h2 = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 24,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const h3 = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 20,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const bodyLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 18,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const body = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const bodySmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const label = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  static const timer = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 48,
    height: 1,
    fontWeight: FontWeight.w700,
    color: AppColors.secondaryMain,
  );

  static const emphasis = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 16,
    height: 1.4,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
    color: AppColors.primaryMain,
  );

  static const buttonPrimary = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 18,
    height: 1,
    fontWeight: FontWeight.w700,
    color: AppColors.backgroundPrimary,
  );

  static const buttonSecondary = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamily,
    fontSize: 16,
    height: 1,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
}

abstract final class OutOfTheLoopTheme {
  static ThemeData get dark {
    final colorScheme = const ColorScheme.dark(
      primary: AppColors.primaryMain,
      onPrimary: AppColors.backgroundPrimary,
      secondary: AppColors.secondaryMain,
      onSecondary: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.textPrimary,
      surface: AppColors.backgroundSecondary,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTypography.primaryFontFamily,
      fontFamilyFallback: AppTypography.fallbackFontFamily,
      scaffoldBackgroundColor: AppColors.backgroundPrimary,
      canvasColor: AppColors.backgroundPrimary,
      cardColor: AppColors.backgroundSecondary,
      disabledColor: AppColors.textDisabled,
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        displayLarge: AppTypography.h1,
        headlineMedium: AppTypography.h2,
        titleLarge: AppTypography.h3,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.body,
        bodySmall: AppTypography.bodySmall,
        labelSmall: AppTypography.label,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundPrimary,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTypography.h3,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundSecondary,
        border: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: BorderSide(color: AppColors.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: BorderSide(color: AppColors.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: BorderSide(color: AppColors.borderFocus, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.backgroundSecondary,
        indicatorColor: AppColors.overlayGlow,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final color = states.contains(WidgetState.selected)
              ? AppColors.primaryMain
              : AppColors.textTertiary;
          return AppTypography.label.copyWith(
            color: color,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.primaryMain
                : AppColors.textTertiary,
          );
        }),
      ),
    );
  }
}
