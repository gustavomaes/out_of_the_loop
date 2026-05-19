import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../theme/display_typography.dart';
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

  static const _borderRadius = 32.0;
  static const _shadowOffset = 4.0;
  static const _borderWidth = 4.0;

  @override
  Widget build(BuildContext context) {
    final primary = Color(category.primaryArgb);
    final secondary = Color(category.secondaryArgb);
    final labelColor = contrastingForeground(primary);
    final iconColor = contrastingForeground(secondary);
    final icon = categoryIconFor(category.iconKey);

    return Padding(
      padding: const EdgeInsets.only(right: _shadowOffset, bottom: _shadowOffset),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Transform.translate(
                  offset: const Offset(_shadowOffset, _shadowOffset),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(_borderRadius),
                    border: Border.all(color: Colors.black, width: _borderWidth),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 68,
                          height: 68,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(icon, size: 36, color: iconColor),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          label,
                          style: DisplayTypography.rubikCategoryCardLabel(
                            color: labelColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
