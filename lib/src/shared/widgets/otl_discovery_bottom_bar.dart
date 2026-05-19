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

  static const _barHeight = 96.0;
  static const _topBorderWidth = 4.0;
  static const _horizontalPadding = 8.0;
  static const _topPadding = 4.0;
  static const _activeSlotHeight = 52.0;
  static const _activePillLift = 16.0;
  static const _shadowOffset = 4.0;
  static const _inactiveHorizontalPadding = 16.0;
  static const _inactiveVerticalPadding = 8.0;
  static const _iconLabelGap = 4.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = <_DiscoveryNavItem>[
      _DiscoveryNavItem(
        route: AppRoutes.home,
        label: l10n.navPlay,
        icon: _DiscoveryNavIcon.play,
      ),
      _DiscoveryNavItem(
        route: AppRoutes.categories,
        label: l10n.navCategories,
        icon: _DiscoveryNavIcon.categories,
      ),
      _DiscoveryNavItem(
        route: AppRoutes.settings,
        label: l10n.navProfile,
        icon: _DiscoveryNavIcon.profile,
      ),
    ];

    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.none,
      child: DecoratedBox(
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
          child: SizedBox(
            height: _barHeight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                _horizontalPadding,
                _topPadding,
                _horizontalPadding,
                0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
      ),
    );
  }
}

enum _DiscoveryNavIcon { play, categories, profile }

final class _DiscoveryNavItem {
  const _DiscoveryNavItem({
    required this.route,
    required this.label,
    required this.icon,
  });

  final String route;
  final String label;
  final _DiscoveryNavIcon icon;
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
      return SizedBox(
        height: OtlDiscoveryBottomBar._activeSlotHeight,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -OtlDiscoveryBottomBar._activePillLift,
              left: 0,
              right: 0,
              child: _ActiveNavPill(item: item, onTap: onTap),
            ),
          ],
        ),
      );
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: OtlDiscoveryBottomBar._inactiveHorizontalPadding,
            vertical: OtlDiscoveryBottomBar._inactiveVerticalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: OtlDiscoveryBottomBar._iconLabelGap,
                ),
                child: _DiscoveryNavIconWidget(
                  icon: item.icon,
                  color: BrutalistColors.sectionLabel,
                ),
              ),
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

  static const _horizontalPadding = 18.0;
  static const _verticalPadding = 10.0;
  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final labelStyle = DisplayTypography.bottomNavLabel(color: Colors.black);
    final content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: OtlDiscoveryBottomBar._iconLabelGap,
            ),
            child: _DiscoveryNavIconWidget(
              icon: item.icon,
              color: Colors.black,
            ),
          ),
          Text(
            item.label,
            style: labelStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(
        right: OtlDiscoveryBottomBar._shadowOffset,
        bottom: OtlDiscoveryBottomBar._shadowOffset,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Transform.translate(
                offset: const Offset(
                  OtlDiscoveryBottomBar._shadowOffset,
                  OtlDiscoveryBottomBar._shadowOffset,
                ),
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Opacity(opacity: 0, child: content),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: BrutalistColors.lime,
                  border: Border.all(
                    color: Colors.black,
                    width: _borderWidth,
                  ),
                ),
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiscoveryNavIconWidget extends StatelessWidget {
  const _DiscoveryNavIconWidget({
    required this.icon,
    required this.color,
  });

  final _DiscoveryNavIcon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return switch (icon) {
      _DiscoveryNavIcon.play => Icon(
        Icons.sports_esports_outlined,
        size: 24,
        color: color,
      ),
      _DiscoveryNavIcon.profile => Icon(
        Icons.person_outline,
        size: 22,
        color: color,
      ),
      _DiscoveryNavIcon.categories => _CategoriesNavIcon(color: color),
    };
  }
}

/// Figma categories tab icon (triangle, square, circle).
class _CategoriesNavIcon extends StatelessWidget {
  const _CategoriesNavIcon({required this.color});

  final Color color;

  static const _size = 23.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22.45,
      height: _size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 5,
            child: Icon(
              Icons.change_history,
              size: 11,
              color: color,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Icon(
              Icons.square,
              size: 10,
              color: color,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 1,
            child: Icon(
              Icons.circle,
              size: 9,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
