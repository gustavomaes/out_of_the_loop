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
    this.contentLanguageLabel,
    super.key,
  });
  final Category category;
  final String label;
  final String? contentLanguageLabel;
  final VoidCallback onTap;
  static const shadowOffset = 0.0;
  static const borderWidth = 1.0;
  @override
  Widget build(BuildContext context) {
    final accent = Color(category.primaryArgb);
    return Material(
      color: BrutalistColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: BrutalistColors.headerBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: otlTap(context, onTap),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      categoryIconFor(category.iconKey),
                      color: contrastingForeground(accent),
                      size: 20,
                    ),
                  ),
                  if (contentLanguageLabel != null) ...[
                    const Spacer(),
                    Tooltip(
                      message: contentLanguageLabel!,
                      child: Text(
                        'EN',
                        semanticsLabel: contentLanguageLabel,
                        style: DisplayTypography.spaceGroteskMeta(
                          color: BrutalistColors.sectionLabel,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: DisplayTypography.rubikCategoryCardLabel(
                        color: BrutalistColors.cardText,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
