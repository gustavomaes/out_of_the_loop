import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../data/content/local_content_repository.dart';
import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_neon_action.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import '../packs/packs_controller.dart';
import 'widgets/category_header.dart';
import 'widgets/otl_category_bento_grid.dart';

class CategorySelectionScreen extends StatefulWidget {
  CategorySelectionScreen({
    LocalContentRepository? repository,
    this.language = SupportedLanguage.en,
    this.onContinue,
    this.footer,
    this.packsController,
    this.onExplorePacks,
    super.key,
  }) : repository = repository ?? LocalContentRepository();

  final Widget? footer;
  final PacksController? packsController;
  final VoidCallback? onExplorePacks;
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
    _listenToPacks();
  }

  @override
  void didUpdateWidget(CategorySelectionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.packsController != widget.packsController) {
      oldWidget.packsController?.removeListener(_onPacksChanged);
      _listenToPacks();
    }
    if (oldWidget.repository != widget.repository ||
        oldWidget.language != widget.language) {
      _categoriesFuture = widget.repository.listCategories(widget.language);
    }
  }

  void _listenToPacks() {
    final controller = widget.packsController;
    if (controller == null) return;
    controller.addListener(_onPacksChanged);
    unawaited(Future<void>.microtask(controller.refresh));
  }

  void _onPacksChanged() {
    // The shop can refresh its shared controller while its route is building.
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    } else if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.packsController?.removeListener(_onPacksChanged);
    super.dispose();
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

            final controller = widget.packsController;
            final ownedPacks =
                controller?.packs
                    .where((pack) => controller.owns(pack.id))
                    .toList() ??
                [];
            final categories = [
              ...snapshot.data ?? const <Category>[],
              for (final pack in ownedPacks) pack.category,
            ];

            return OtlContentWidth(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                children: [
                  CategoryHeader(
                    title: l10n.pickCategory,
                    subtitle: l10n.pickCategorySubtitle,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.readyToPlay,
                    style: DisplayTypography.rubikCategoryCardLabel(
                      color: BrutalistColors.cardText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OtlCategoryBentoGrid(
                    categories: categories,
                    packCategoryIds: ownedPacks.map((pack) => pack.id).toSet(),
                    language: widget.language,
                    l10n: l10n,
                    onCategorySelected: _onCategorySelected,
                  ),
                  if (widget.onExplorePacks != null) ...[
                    const SizedBox(height: 24),
                    OtlNeonAction(
                      label: l10n.explorePacks,
                      primary: false,
                      icon: Icons.auto_awesome_outlined,
                      onPressed: widget.onExplorePacks,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.packsSubtitle,
                      style: DisplayTypography.plusJakartaBody(
                        color: BrutalistColors.sectionLabel,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (widget.footer != null) widget.footer!,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
