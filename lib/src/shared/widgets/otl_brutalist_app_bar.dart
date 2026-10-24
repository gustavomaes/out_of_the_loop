import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../sound/sound_effects_scope.dart';

class OtlBrutalistAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OtlBrutalistAppBar({required this.title, this.onBack, super.key});
  final String title;
  final VoidCallback? onBack;
  @override
  Size get preferredSize => const Size.fromHeight(64);
  @override
  Widget build(BuildContext context) => AppBar(
    toolbarHeight: 64,
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: onBack == null
        ? null
        : BackButton(onPressed: otlTap(context, onBack)),
    title: Text(
      title,
      style: DisplayTypography.rubikDiscoveryAppBarTitle(
        color: BrutalistColors.cardText,
      ),
    ),
    backgroundColor: BrutalistColors.screenBackground,
    surfaceTintColor: Colors.transparent,
  );
}
