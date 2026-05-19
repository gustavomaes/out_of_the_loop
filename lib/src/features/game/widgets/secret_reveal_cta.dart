import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SecretRevealCta extends StatelessWidget {
  const SecretRevealCta({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  static const _height = 64.0;
  static const _shadowDx = 4.0;
  static const _shadowDy = 8.0;

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
                  child: Center(
                    child: Text(
                      label,
                      style: DisplayTypography.rubikHomeButton(
                        color: BrutalistColors.homePrimaryButtonText,
                      ),
                      textAlign: TextAlign.center,
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
