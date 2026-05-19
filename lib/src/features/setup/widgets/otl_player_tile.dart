import 'package:flutter/material.dart';

import '../category_icon.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../theme/theme.dart';

class OtlPlayerTile extends StatelessWidget {
  const OtlPlayerTile({
    required this.name,
    required this.avatarSeed,
    required this.backgroundColor,
    required this.onRemove,
    required this.removeTooltip,
    super.key,
  });

  final String name;
  final String avatarSeed;
  final Color backgroundColor;
  final VoidCallback onRemove;
  final String removeTooltip;

  static const _shadowOffset = 4.0;
  static const _borderWidth = 4.0;

  @override
  Widget build(BuildContext context) {
    final labelColor = contrastingForeground(backgroundColor);

    return Padding(
      padding: const EdgeInsets.only(
        right: _shadowOffset,
        bottom: _shadowOffset,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(_shadowOffset, _shadowOffset),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.black, width: _borderWidth),
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: Colors.black, width: _borderWidth),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: BrutalistColors.playerAvatarFrame,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: PlayerAvatar(
                        name: name,
                        seed: avatarSeed,
                        size: 44,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      name.toUpperCase(),
                      style: DisplayTypography.rubikPlayerCardName(
                        color: labelColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: onRemove,
                    tooltip: removeTooltip,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    icon: Icon(
                      Icons.delete_outline,
                      color: labelColor,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color playerCardColorForIndex(int index) {
  const colors = [
    BrutalistColors.playerCardPink,
    BrutalistColors.playerCardYellow,
    BrutalistColors.playerCardGreen,
  ];
  return colors[index % colors.length];
}
