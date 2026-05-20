import 'package:flutter/material.dart';

import '../../data/content/local_content_repository.dart';
import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/category_header.dart';
import 'widgets/otl_category_bento_grid.dart';

class CategorySelectionScreen extends StatefulWidget {
  CategorySelectionScreen({
    LocalContentRepository? repository,
    this.language = SupportedLanguage.ptBr,
    this.onContinue,
    super.key,
  }) : repository = repository ?? LocalContentRepository();

  final LocalContentRepository repository;
  final SupportedLanguage language;
  final ValueChanged<Category>? onContinue;

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
        appBar: const OtlBrutalistDiscoveryAppBar(
          showBack: false,
          showSettings: false,
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
                CategoryHeader(
                  title: l10n.pickCategory,
                  subtitle: l10n.pickCategorySubtitle,
                ),
                const SizedBox(height: 24),
                OtlCategoryBentoGrid(
                  categories: categories,
                  language: widget.language,
                  l10n: l10n,
                  onCategorySelected: _onCategorySelected,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
