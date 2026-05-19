import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_routes.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

/// Figma-aligned discovery bottom bar (PLAY / CATEGORIES / PROFILE).
class OtlDiscoveryBottomBar extends StatelessWidget {
  const OtlDiscoveryBottomBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _topBorderWidth = 4.0;
  static const _horizontalPadding = 8.0;
  static const _activePillLift = 16.0;
  static const _slotHeight = 60.0;
  static const _shadowOffset = 4.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = <_DiscoveryNavItem>[
      _DiscoveryNavItem(
        route: AppRoutes.home,
        label: l10n.navPlay,
        icon: Icons.sports_esports_outlined,
      ),
      _DiscoveryNavItem(
        route: AppRoutes.categories,
        label: l10n.navCategories,
        icon: Icons.category_outlined,
      ),
      _DiscoveryNavItem(
        route: AppRoutes.settings,
        label: l10n.navProfile,
        icon: Icons.person_outline,
      ),
    ];

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: BrutalistColors.cardBackground,
        border: Border(
          top: BorderSide(
            color: BrutalistColors.headerBorder,
            width: _topBorderWidth,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            _horizontalPadding,
            _topBorderWidth + _activePillLift,
            _horizontalPadding,
            8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var index = 0; index < items.length; index++)
                Expanded(
                  child: _DiscoveryNavSlot(
                    item: items[index],
                    selected: navigationShell.currentIndex == index,
                    onTap: () {
                      if (navigationShell.currentIndex != index) {
                        navigationShell.goBranch(
                          index,
                          initialLocation:
                              index == navigationShell.currentIndex,
                        );
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _DiscoveryNavItem {
  const _DiscoveryNavItem({
    required this.route,
    required this.label,
    required this.icon,
  });

  final String route;
  final String label;
  final IconData icon;
}

class _DiscoveryNavSlot extends StatelessWidget {
  const _DiscoveryNavSlot({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _DiscoveryNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return _ActiveNavPill(item: item, onTap: onTap);
    }

    return _InactiveNavItem(item: item, onTap: onTap);
  }
}

class _InactiveNavItem extends StatelessWidget {
  const _InactiveNavItem({required this.item, required this.onTap});

  final _DiscoveryNavItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labelStyle = DisplayTypography.bottomNavLabel(
      color: BrutalistColors.sectionLabel,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: OtlDiscoveryBottomBar._slotHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 22, color: BrutalistColors.sectionLabel),
              const SizedBox(height: 4),
              Text(item.label, style: labelStyle, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActiveNavPill extends StatelessWidget {
  const _ActiveNavPill({required this.item, required this.onTap});

  final _DiscoveryNavItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labelStyle = DisplayTypography.bottomNavLabel(color: Colors.black);

    return SizedBox(
      height: OtlDiscoveryBottomBar._slotHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: -OtlDiscoveryBottomBar._activePillLift,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: OtlDiscoveryBottomBar._activePillLift +
                      OtlDiscoveryBottomBar._shadowOffset,
                  bottom: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: OtlDiscoveryBottomBar._activePillLift,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: OtlDiscoveryBottomBar._shadowOffset,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onTap,
                        borderRadius: BorderRadius.circular(32),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: BrutalistColors.lime,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(item.icon, size: 22, color: Colors.black),
                                const SizedBox(height: 4),
                                Text(
                                  item.label,
                                  style: labelStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
