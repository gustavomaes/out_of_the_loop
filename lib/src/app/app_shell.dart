import 'package:flutter/material.dart';

import '../shared/widgets/shared_widgets.dart';
import '../theme/app_tokens.dart';
import 'app_routes.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.routeName,
    required this.title,
    required this.child,
    super.key,
  });

  final String routeName;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final showBottomNavigation = AppRoutes.bottomNavigationRoutes.contains(
      routeName,
    );

    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: child,
        ),
      ),
      bottomNavigationBar: showBottomNavigation
          ? _DiscoveryNavigationBar(currentRoute: routeName)
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

class _DiscoveryNavigationBar extends StatelessWidget {
  const _DiscoveryNavigationBar({required this.currentRoute});

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: AppColors.backgroundSecondary,
      indicatorColor: AppColors.overlayGlow,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        final route = AppRoutes.bottomNavigationRoutes[index];
        if (route != currentRoute) {
          Navigator.of(context).pushReplacementNamed(route);
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.play_arrow), label: 'Play'),
        NavigationDestination(icon: Icon(Icons.grid_view), label: 'Categories'),
        NavigationDestination(icon: Icon(Icons.help_outline), label: 'How To'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }

  int get _selectedIndex {
    final index = AppRoutes.bottomNavigationRoutes.indexOf(currentRoute);
    return index < 0 ? 0 : index;
  }
}
