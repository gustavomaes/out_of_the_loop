import 'package:flutter/material.dart';

import 'app_colors.dart';

export 'app_colors.dart' show BrutalistColors;

/// Wraps a screen with brutalist scaffold/canvas colors.
abstract final class BrutalistScreenTheme {
  static Widget wrap(BuildContext context, Widget child) {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: BrutalistColors.screenBackground,
        canvasColor: BrutalistColors.screenBackground,
      ),
      child: child,
    );
  }
}
