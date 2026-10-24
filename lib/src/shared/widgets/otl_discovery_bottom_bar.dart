import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../theme/theme.dart';
import '../sound/sound_effects_scope.dart';

class OtlDiscoveryBottomBar extends StatelessWidget {
  const OtlDiscoveryBottomBar({required this.navigationShell, super.key});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) =>
          otlTap(context, () => navigationShell.goBranch(index))!(),
      backgroundColor: BrutalistColors.screenBackground,
      height: 72,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.play_arrow_outlined),
          selectedIcon: const Icon(Icons.play_arrow),
          label: l10n.navPlay,
        ),
        NavigationDestination(
          icon: const Icon(Icons.grid_view_outlined),
          selectedIcon: const Icon(Icons.grid_view_rounded),
          label: l10n.navCategories,
        ),
        NavigationDestination(
          icon: const Icon(Icons.tune_outlined),
          label: l10n.navProfile,
        ),
      ],
    );
  }
}
