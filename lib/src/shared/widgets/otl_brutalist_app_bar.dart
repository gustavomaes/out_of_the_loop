import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class OtlBrutalistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OtlBrutalistAppBar({required this.title, super.key});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(72);

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
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: 72,
            child: Center(
              child: Text(
                title,
                style: DisplayTypography.rubikDiscoveryAppBarTitle(
                  color: BrutalistColors.lime,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
