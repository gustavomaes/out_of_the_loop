import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class VotingActionButton extends StatelessWidget {
  const VotingActionButton({
    required this.label,
    required this.enabled,
    this.onPressed,
    super.key,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  static const _shadowDx = 4.0;
  static const _shadowDy = 4.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (enabled)
            Positioned.fill(
              child: Transform.translate(
                offset: const Offset(_shadowDx, _shadowDy),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                ),
              ),
            ),
          SizedBox(
            width: 100,
            height: 56,
            child: Material(
              color: enabled
                  ? BrutalistColors.playerCardPink
                  : BrutalistColors.headerBorder.withValues(alpha: 0.3),
              child: InkWell(
                onTap: enabled ? onPressed : null,
                child: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: enabled
                          ? Colors.black
                          : BrutalistColors.headerBorder,
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: DisplayTypography.rubikVotingButton(
                        color: enabled
                            ? BrutalistColors.turnChipText
                            : BrutalistColors.sectionLabel,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
