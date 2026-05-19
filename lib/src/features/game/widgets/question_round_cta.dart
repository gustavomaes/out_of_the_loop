import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class QuestionRoundCta extends StatelessWidget {
  const QuestionRoundCta({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  static const _height = 72.0;
  static const _shadowDx = 8.0;
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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
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
                      Text(
                        label,
                        style: DisplayTypography.rubikQuestionRoundCta(
                          color: BrutalistColors.homePrimaryButtonText,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.check_circle_outline,
                        color: BrutalistColors.homePrimaryButtonText,
                        size: 20,
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
