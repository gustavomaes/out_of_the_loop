import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/discovery_shell.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

/// Figma top bar: back, fixed app name, settings.
class OtlBrutalistDiscoveryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OtlBrutalistDiscoveryAppBar({
    this.onBack,
    this.onSettings,
    super.key,
  });

  static const appName = 'OUT OF THE LOOP';

  final VoidCallback? onBack;
  final VoidCallback? onSettings;

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
                  IconButton(
                    onPressed:
                        onBack ?? () => context.goDiscoveryTab(AppRoutes.home),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 22,
                    ),
                    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  ),
                  Expanded(
                    child: Text(
                      appName,
                      style: DisplayTypography.rubikTitle(
                        color: BrutalistColors.lime,
                        fontSize: 28,
                        height: 32 / 28,
                        letterSpacing: -1.4,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed:
                        onSettings ??
                        () => context.goDiscoveryTab(AppRoutes.settings),
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                    tooltip: 'Settings',
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
