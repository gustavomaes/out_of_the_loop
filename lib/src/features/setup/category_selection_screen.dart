import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../data/content/local_content_repository.dart';
import '../../domain/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

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
  Category? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      routeName: AppRoutes.categories,
      title: 'Categories',
      child: FutureBuilder<List<Category>>(
        future: widget.repository.listCategories(widget.language),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Could not load categories.',
                style: AppTypography.body,
              ),
            );
          }
          final categories = snapshot.data ?? const <Category>[];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Pick a Category', style: AppTypography.h2),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final selected = category == _selectedCategory;
                    return InkWell(
                      borderRadius: AppRadius.borderLg,
                      onTap: () => setState(() => _selectedCategory = category),
                      child: OtlCard(
                        selected: selected,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _iconFor(category.iconKey),
                              color: selected
                                  ? AppColors.secondaryMain
                                  : AppColors.primaryMain,
                              size: 32,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              category.name.valueFor(widget.language),
                              style: AppTypography.h3,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              OtlButton.primary(
                label: 'PLAY',
                onPressed: _selectedCategory == null
                    ? null
                    : () => widget.onContinue?.call(_selectedCategory!),
              ),
            ],
          );
        },
      ),
    );
  }

  IconData _iconFor(String? iconKey) {
    return switch (iconKey) {
      'restaurant' => Icons.restaurant,
      'sports' => Icons.sports_esports,
      'movies' => Icons.movie_filter_outlined,
      _ => Icons.category_outlined,
    };
  }
}
