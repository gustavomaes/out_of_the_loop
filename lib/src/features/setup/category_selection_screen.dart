import 'package:flutter/material.dart';

import '../../data/content/local_content_repository.dart';
import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';
import 'category_localization.dart';
import 'widgets/otl_category_tile.dart';

class CategorySelectionScreen extends StatefulWidget {
  CategorySelectionScreen({
    LocalContentRepository? repository,
    this.language = SupportedLanguage.ptBr,
    this.onContinue,
    this.onBack,
    this.onSettings,
    super.key,
  }) : repository = repository ?? LocalContentRepository();

  final LocalContentRepository repository;
  final SupportedLanguage language;
  final ValueChanged<Category>? onContinue;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = widget.repository.listCategories(widget.language);
  }

  @override
  void didUpdateWidget(CategorySelectionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repository != widget.repository ||
        oldWidget.language != widget.language) {
      _categoriesFuture = widget.repository.listCategories(widget.language);
    }
  }

  void _onCategorySelected(Category category) {
    widget.onContinue?.call(category);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BrutalistScreenTheme.wrap(
      context,
      Scaffold(
        appBar: OtlBrutalistDiscoveryAppBar(
          onBack: widget.onBack,
          onSettings: widget.onSettings,
        ),
        body: FutureBuilder<List<Category>>(
          future: _categoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  l10n.categoriesLoadError,
                  style: DisplayTypography.plusJakartaBody(
                    color: BrutalistColors.cardText,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final categories = snapshot.data ?? const <Category>[];

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 134),
              children: [
                _CategoryHeader(
                  title: l10n.pickCategory,
                  subtitle: l10n.pickCategorySubtitle,
                ),
                const SizedBox(height: 24),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return OtlCategoryTile(
                      category: category,
                      label: l10n.categoryDisplayName(
                        categoryId: category.id,
                        fallback: category.name,
                        language: widget.language,
                      ),
                      onTap: () => _onCategorySelected(category),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: DisplayTypography.rubikCategoryTitle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: DisplayTypography.plusJakartaBody(
            color: BrutalistColors.sectionLabel,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
