import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/discovery_shell.dart';
import '../icons/icons.dart';
import '../../theme/theme.dart';

/// Figma top bar: back, fixed app name, settings.
class OtlBrutalistDiscoveryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OtlBrutalistDiscoveryAppBar({
    this.onBack,
    this.onSettings,
    this.showBack = true,
    this.showSettings = true,
    super.key,
  });

  static const appName = 'OUT OF THE LOOP';
  static const _sideSlotWidth = 48.0;

  final VoidCallback? onBack;
  final VoidCallback? onSettings;
  final bool showBack;
  final bool showSettings;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BrutalistColors.headerBackground,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: BrutalistColors.headerBackground,
          border: Border(
            bottom: BorderSide(color: BrutalistColors.headerBorder, width: 4),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  if (showBack)
                    IconButton(
                      onPressed: onBack ??
                          () => context.goDiscoveryTab(AppRoutes.home),
                      icon: const Icon(
                        OtlIcons.arrowBack,
                        color: Colors.white,
                        size: 22,
                      ),
                      tooltip:
                          MaterialLocalizations.of(context).backButtonTooltip,
                    )
                  else
                    const SizedBox(width: _sideSlotWidth),
                  Expanded(
                    child: Text(
                      appName,
                      style: DisplayTypography.rubikDiscoveryAppBarTitle(
                        color: BrutalistColors.lime,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (showSettings)
                    IconButton(
                      onPressed: onSettings ??
                          () => context.goDiscoveryTab(AppRoutes.settings),
                      icon: const Icon(
                        OtlIcons.settings,
                        color: Colors.white,
                        size: 22,
                      ),
                      tooltip: 'Settings',
                    )
                  else
                    const SizedBox(width: _sideSlotWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
