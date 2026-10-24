import 'package:flutter/material.dart';
import '../../app/app_routes.dart';
import '../../app/discovery_shell.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../theme/theme.dart';
import '../sound/sound_effects_scope.dart';

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
  final VoidCallback? onBack;
  final VoidCallback? onSettings;
  final bool showBack;
  final bool showSettings;
  @override
  Size get preferredSize => const Size.fromHeight(64);
  @override
  Widget build(BuildContext context) => AppBar(
    toolbarHeight: 64,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: showBack
        ? BackButton(
            onPressed: otlTap(
              context,
              onBack ?? () => context.goDiscoveryTab(AppRoutes.home),
            ),
          )
        : null,
    title: Text(
      appName,
      style: DisplayTypography.rubikDiscoveryAppBarTitle(
        color: BrutalistColors.cardText,
      ),
    ),
    actions: [
      if (showSettings)
        IconButton(
          tooltip: AppLocalizations.of(context)!.settings,
          onPressed: otlTap(
            context,
            onSettings ?? () => context.goDiscoveryTab(AppRoutes.settings),
          ),
          icon: const Icon(
            Icons.settings_outlined,
            color: BrutalistColors.sectionLabel,
          ),
        ),
      const SizedBox(width: 8),
    ],
    backgroundColor: BrutalistColors.screenBackground,
    surfaceTintColor: Colors.transparent,
  );
}
