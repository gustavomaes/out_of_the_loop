import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class PlayerTurnChip extends StatelessWidget {
  const PlayerTurnChip({required this.label, super.key});

  final String label;

  static const _shadowDx = 4.0;
  static const _shadowDy = 4.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(_shadowDx, _shadowDy),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: BrutalistColors.playerCardPink,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: Colors.black, width: 4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              child: Text(
                label,
                style: DisplayTypography.spaceGroteskTurnChip(
                  color: BrutalistColors.turnChipText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
