import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../shared/sound/sound_effects_scope.dart';
import '../../../theme/theme.dart';
import '../category_icon.dart';

class OtlCategoryTile extends StatelessWidget {
  const OtlCategoryTile({
    required this.category,
    required this.label,
    required this.onTap,
    super.key,
  });

  final Category category;
  final String label;
  final VoidCallback onTap;

  static const shadowOffset = 4.0;
  static const borderWidth = 4.0;
  static const _iconBadgeSize = 68.0;
  static const _iconGraphicSize = 36.0;
  static const _iconLabelGap = 8.0;
  static const _labelLineHeight = 20.0;
  static const _maxVerticalPadding = 31.5;
  static const _minVerticalPadding = 12.0;

  @override
  Widget build(BuildContext context) {
    final primary = Color(category.primaryArgb);
    final labelStyle = _labelStyleFor(primary);
    final icon = categoryIconFor(category.iconKey);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = constraints.maxHeight - shadowOffset;
        final verticalPadding = cardHeight.isFinite
            ? ((cardHeight -
                        _iconBadgeSize -
                        _iconLabelGap -
                        _labelLineHeight) /
                    2)
                .clamp(_minVerticalPadding, _maxVerticalPadding)
            : _maxVerticalPadding;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: otlTap(context, onTap),
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: shadowOffset,
                  top: shadowOffset,
                  right: 0,
                  bottom: 0,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  right: shadowOffset,
                  bottom: shadowOffset,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: primary,
                      border: Border.all(
                        color: Colors.black,
                        width: borderWidth,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: verticalPadding,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: _iconBadgeSize,
                              height: _iconBadgeSize,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.25),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                icon,
                                size: _iconGraphicSize,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: _iconLabelGap),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 140,
                              ),
                              child: Text(
                                label,
                                style: labelStyle,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
          ),
        );
      },
    );
  }

  TextStyle _labelStyleFor(Color primary) {
    final labelColor = contrastingForeground(primary);
    final base = DisplayTypography.rubikCategoryCardLabel(color: labelColor);
    if (labelColor != Colors.white) {
      return base;
    }
    return base.copyWith(
      shadows: const [
        Shadow(offset: Offset(2, 2), color: Colors.black),
      ],
    );
  }
}
