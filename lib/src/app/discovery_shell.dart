import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shared/widgets/shared_widgets.dart';
import 'app_routes.dart';

extension DiscoveryNavigation on BuildContext {
  /// Switches discovery tabs with directional slide via [StatefulNavigationShell].
  void goDiscoveryTab(String route) {
    final shell = StatefulNavigationShell.maybeOf(this);
    if (shell != null) {
      shell.goBranch(DiscoveryShell.branchIndexForRoute(route));
      return;
    }
    go(route);
  }
}

/// Persistent shell for discovery tabs (PLAY / CATEGORIES / PROFILE).
class DiscoveryShell extends StatelessWidget {
  const DiscoveryShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static int branchIndexForRoute(String route) {
    final index = AppRoutes.bottomNavigationRoutes.indexOf(route);
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ClipRect(
        clipBehavior: Clip.none,
        child: OtlDiscoveryBottomBar(
          navigationShell: navigationShell,
        ),
      ),
    );
  }
}
