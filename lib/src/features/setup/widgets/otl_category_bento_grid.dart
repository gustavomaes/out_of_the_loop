import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../category_localization.dart';
import 'otl_category_tile.dart';

/// Compact two-column catalog, with extra room for larger text.
class OtlCategoryBentoGrid extends StatelessWidget {
  const OtlCategoryBentoGrid({
    required this.categories,
    required this.language,
    required this.l10n,
    required this.onCategorySelected,
    this.packCategoryIds = const {},
    super.key,
  });

  final List<Category> categories;
  final Set<String> packCategoryIds;
  final SupportedLanguage language;
  final AppLocalizations l10n;
  final ValueChanged<Category> onCategorySelected;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columns =
          constraints.maxWidth < 300 &&
              MediaQuery.textScalerOf(context).scale(16) > 20
          ? 1
          : 2;
      final height = 72 + MediaQuery.textScalerOf(context).scale(40);
      return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisExtent: height,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) => OtlCategoryTile(
          category: categories[index],
          contentLanguageLabel: packCategoryIds.contains(categories[index].id)
              ? l10n.packEnglishContent
              : null,
          label: l10n.categoryDisplayName(
            categoryId: categories[index].id,
            fallback: categories[index].name,
            language: packCategoryIds.contains(categories[index].id)
                ? SupportedLanguage.en
                : language,
          ),
          onTap: () => onCategorySelected(categories[index]),
        ),
      );
    },
  );
}
