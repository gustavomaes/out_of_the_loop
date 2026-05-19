import 'package:flutter/material.dart';

import '../shared/widgets/shared_widgets.dart';
import '../theme/app_tokens.dart';
import 'app_routes.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.routeName,
    required this.title,
    required this.child,
    this.appBar,
    this.bodyPadding = const EdgeInsets.all(AppSpacing.md),
    super.key,
  });

  final String routeName;
  final String title;
  final Widget child;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry bodyPadding;

  @override
  Widget build(BuildContext context) {
    final showBottomNavigation = AppRoutes.bottomNavigationRoutes.contains(
      routeName,
    );

    return Scaffold(
      appBar: appBar ?? AppBar(title: Text(title), centerTitle: true),
      body: SafeArea(
        child: Padding(padding: bodyPadding, child: child),
      ),
      bottomNavigationBar: showBottomNavigation
          ? OtlDiscoveryBottomBar(currentRoute: routeName)
          : null,
    );
  }
}

class PlaceholderRoutePage extends StatelessWidget {
  const PlaceholderRoutePage({
    required this.title,
    required this.routeName,
    super.key,
  });

  final String title;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      routeName: routeName,
      title: title,
      child: Center(
        child: OtlCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppTypography.h2, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.sm),
              Text(
                routeName,
                style: AppTypography.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

