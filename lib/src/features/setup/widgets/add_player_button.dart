import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class AddPlayerButton extends StatelessWidget {
  const AddPlayerButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  static const _height = 64.0;
  static const _shadowOffset = 4.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _shadowOffset, bottom: _shadowOffset),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(_shadowOffset, _shadowOffset),
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: _height,
            width: double.infinity,
            child: Material(
              color: BrutalistColors.lime,
              child: InkWell(
                onTap: onPressed,
                child: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: BrutalistColors.homePrimaryButtonText,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: DisplayTypography.rubikHomeButton(
                          color: BrutalistColors.homePrimaryButtonText,
                        ),
                      ),
                    ],
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
