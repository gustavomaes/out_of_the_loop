import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../category_localization.dart';
import 'otl_category_tile.dart';

/// Figma bento grid: 2 columns with alternating row heights (167 / 156 / 167 / 167).
class OtlCategoryBentoGrid extends StatelessWidget {
  const OtlCategoryBentoGrid({
    required this.categories,
    required this.language,
    required this.l10n,
    required this.onCategorySelected,
    super.key,
  });

  final List<Category> categories;
  final SupportedLanguage language;
  final AppLocalizations l10n;
  final ValueChanged<Category> onCategorySelected;

  static const _crossAxisSpacing = 16.0;
  static const _mainAxisSpacing = 16.0;
  static const _rowHeights = <double>[167, 156, 167, 167];

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    final leftColumn = <Category>[];
    final rightColumn = <Category>[];
    for (var index = 0; index < categories.length; index++) {
      if (index.isEven) {
        leftColumn.add(categories[index]);
      } else {
        rightColumn.add(categories[index]);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _BentoColumn(
            categories: leftColumn,
            language: language,
            l10n: l10n,
            onCategorySelected: onCategorySelected,
          ),
        ),
        const SizedBox(width: _crossAxisSpacing),
        Expanded(
          child: _BentoColumn(
            categories: rightColumn,
            language: language,
            l10n: l10n,
            onCategorySelected: onCategorySelected,
          ),
        ),
      ],
    );
  }
}

class _BentoColumn extends StatelessWidget {
  const _BentoColumn({
    required this.categories,
    required this.language,
    required this.l10n,
    required this.onCategorySelected,
  });

  final List<Category> categories;
  final SupportedLanguage language;
  final AppLocalizations l10n;
  final ValueChanged<Category> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < categories.length; index++) ...[
          if (index > 0) const SizedBox(height: OtlCategoryBentoGrid._mainAxisSpacing),
          SizedBox(
            height: OtlCategoryBentoGrid._rowHeights[
                    index % OtlCategoryBentoGrid._rowHeights.length] +
                OtlCategoryTile.shadowOffset,
            child: OtlCategoryTile(
              category: categories[index],
              label: l10n.categoryDisplayName(
                categoryId: categories[index].id,
                fallback: categories[index].name,
                language: language,
              ),
              onTap: () => onCategorySelected(categories[index]),
            ),
          ),
        ],
      ],
    );
  }
}
