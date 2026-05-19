import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Figma-aligned display typography (Rubik + Plus Jakarta Sans).
abstract final class DisplayTypography {
  static TextStyle rubikTitle({
    required Color color,
    double fontSize = 28,
    double? height,
    double letterSpacing = -0.7,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.rubik(
      fontSize: fontSize,
      height: height ?? (fontSize >= 40 ? 52 / fontSize : 32 / fontSize),
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle plusJakartaBody({
    required Color color,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w500,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      height: 22.5 / 18,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      color: color,
    );
  }

  static TextStyle spaceGroteskSectionLabel({
    required Color color,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 1.4,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      height: 20 / fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  /// Figma bottom-nav labels (Space Grotesk 14 / 1.4 tracking); uses bundled Rubik in tests.
  static TextStyle bottomNavLabel({
    required Color color,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 1.4,
  }) {
    return TextStyle(
      fontFamily: 'Rubik',
      fontSize: fontSize,
      height: 20 / fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle rubikSettingLabel({
    required Color color,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return GoogleFonts.rubik(
      fontSize: fontSize,
      height: 24 / fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle rubikHomeTitle({
    required Color color,
    double fontSize = 48,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    return TextStyle(
      fontFamily: 'Rubik',
      fontSize: fontSize,
      height: 52 / fontSize,
      fontWeight: fontWeight,
      letterSpacing: -2.4,
      color: color,
    );
  }

  static TextStyle rubikHomeButton({
    required Color color,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return TextStyle(
      fontFamily: 'Rubik',
      fontSize: fontSize,
      height: 24 / fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle spaceGroteskMeta({
    required Color color,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 1.4,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      height: 20 / fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }
}
