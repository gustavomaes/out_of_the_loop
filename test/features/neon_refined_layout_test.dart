import 'dart:io';
import 'dart:ui' as ui;

import '../support/category_purchase_gateway.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/previews/neon_previews.dart';
import 'package:outoftheloop/src/data/content/local_content_repository.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/theme/theme.dart';
import 'package:outoftheloop/src/data/content/us_pack_catalog.dart';
import 'package:outoftheloop/src/features/packs/packs_controller.dart';

void main() {
  late LocalContentRepository repository;
  late UsPackCatalog usCatalog;
  setUpAll(() async {
    repository = LocalContentRepository(
      seedJson: await File('assets/content/seed_content.json').readAsString(),
    );
    await repository.listCategories(SupportedLanguage.ptBr);
    usCatalog = UsPackCatalog(
      seedJson: await File('assets/content/us_game_night.json').readAsString(),
    );
    await usCatalog.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
    for (final family in ['Rubik', 'PlusJakartaSans', 'SpaceGrotesk']) {
      final font = FontLoader(family)
        ..addFont(rootBundle.load('assets/fonts/$family[wght].ttf'));
      await font.load();
    }
  });

  for (final size in [
    const Size(320, 640),
    const Size(390, 844),
    const Size(768, 1024),
    const Size(844, 390),
  ]) {
    for (final locale in [
      const Locale('pt', 'BR'),
      const Locale('en'),
      const Locale('es'),
      const Locale('hi'),
      const Locale('ar'),
    ]) {
      testWidgets(
        'all routes fit ${size.width}×${size.height} ${locale.languageCode}',
        (tester) async {
          tester.view.devicePixelRatio = 1;
          tester.view.physicalSize = size;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          final packsController = PacksController(
            catalog: usCatalog,
            gateway: CategoryPurchaseGateway({UsPackCatalog.bundleId}),
          );
          addTearDown(packsController.dispose);
          for (final screen in NeonPreviewScreen.values) {
            final boundaryKey = GlobalKey();
            await tester.pumpWidget(
              MaterialApp(
                key: ValueKey(screen),
                debugShowCheckedModeBanner: false,
                theme: OutOfTheLoopTheme.dark,
                locale: locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    disableAnimations: true,
                    textScaler: TextScaler.linear(size.width == 320 ? 1.4 : 1),
                  ),
                  child: child!,
                ),
                home: RepaintBoundary(
                  key: boundaryKey,
                  child: neonPreviewPage(
                    screen,
                    switch (locale.languageCode) {
                      'ar' => SupportedLanguage.ar,
                      'en' => SupportedLanguage.en,
                      'es' => SupportedLanguage.es,
                      'hi' => SupportedLanguage.hi,
                      _ => SupportedLanguage.ptBr,
                    },
                    repository: repository,
                    packsController: packsController,
                  ),
                ),
              ),
            );
            if (screen == NeonPreviewScreen.categories) {
              for (
                var i = 0;
                i < 30 &&
                    find
                        .byType(CircularProgressIndicator)
                        .evaluate()
                        .isNotEmpty;
                i++
              ) {
                await tester.runAsync(
                  () => Future<void>.delayed(const Duration(milliseconds: 20)),
                );
                await tester.pump(const Duration(milliseconds: 30));
              }
              expect(find.byType(CircularProgressIndicator), findsNothing);
            }
            await tester.pumpAndSettle();
            expect(
              tester.takeException(),
              isNull,
              reason: '${screen.name}, $size, $locale',
            );
            final captureDir = Platform.environment['NEON_CAPTURE_DIR'];
            if (captureDir != null &&
                size.width == 390 &&
                (locale.languageCode == 'pt' || locale.languageCode == 'en')) {
              final boundary =
                  boundaryKey.currentContext!.findRenderObject()!
                      as RenderRepaintBoundary;
              await tester.runAsync(() async {
                final image = await boundary.toImage(pixelRatio: 2);
                final bytes = await image.toByteData(
                  format: ui.ImageByteFormat.png,
                );
                await Directory(captureDir).create(recursive: true);
                await File(
                  '$captureDir/${locale.languageCode}-${screen.name}.png',
                ).writeAsBytes(bytes!.buffer.asUint8List());
                image.dispose();
              });
            }
            await tester.pumpWidget(const SizedBox.shrink());
            await tester.pump();
          }
        },
      );
    }
  }
}
