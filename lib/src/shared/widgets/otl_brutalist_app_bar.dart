import 'package:flutter/material.dart';

import '../icons/icons.dart';
import '../../theme/theme.dart';

class OtlBrutalistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OtlBrutalistAppBar({
    required this.title,
    this.onBack,
    super.key,
  });

  static const _sideSlotWidth = 48.0;

  final String title;
  final VoidCallback? onBack;

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
            child: onBack == null
                ? Center(
                    child: Text(
                      title,
                      style: DisplayTypography.rubikDiscoveryAppBarTitle(
                        color: BrutalistColors.lime,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: onBack,
                          icon: const Icon(
                            OtlIcons.arrowBack,
                            color: Colors.white,
                            size: 22,
                          ),
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).backButtonTooltip,
                        ),
                        Expanded(
                          child: Text(
                            title,
                            style: DisplayTypography.rubikDiscoveryAppBarTitle(
                              color: BrutalistColors.lime,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
