import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Shown while preferences load; matches native launch splash.
class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({super.key});

  static const _iconSize = 120.0;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: BrutalistColors.screenBackground,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/app_icon.png'),
          width: _iconSize,
          height: _iconSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
