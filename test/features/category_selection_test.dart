import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/app_router.dart';
import 'package:outoftheloop/src/app/app_routes.dart';
import 'package:outoftheloop/src/app/game_flow_controller.dart';
import 'package:outoftheloop/src/data/audio/background_music_service.dart';
import 'package:outoftheloop/src/data/audio/sound_effects_service.dart';
import 'package:outoftheloop/src/data/content/local_content_repository.dart';
import 'package:outoftheloop/src/data/content/us_pack_catalog.dart';
import 'package:outoftheloop/src/data/preferences/preferences_repository.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/features/packs/packs_controller.dart';
import 'package:outoftheloop/src/features/packs/packs_screen.dart';
import 'package:outoftheloop/src/features/setup/category_selection_screen.dart';
import 'package:outoftheloop/src/features/setup/match_setup_screen.dart';
import 'package:outoftheloop/src/features/setup/widgets/otl_category_tile.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/theme/theme.dart';

import '../support/category_purchase_gateway.dart';

void main() {
  late LocalContentRepository repository;
  late UsPackCatalog catalog;
  late CategoryPurchaseGateway gateway;
  late PacksController packs;

  setUp(() async {
    repository = LocalContentRepository(
      seedJson: File('assets/content/seed_content.json').readAsStringSync(),
    );
    await repository.listCategories(SupportedLanguage.ptBr);
    catalog = UsPackCatalog(
      seedJson: File('assets/content/us_game_night.json').readAsStringSync(),
    );
    await catalog.load();
    gateway = CategoryPurchaseGateway({'us_backyard'});
    packs = PacksController(gateway: gateway, catalog: catalog);
  });
  tearDown(() => packs.dispose());

  testWidgets(
    'free and owned content share compact cards; store stays separate',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      Category? selected;
      var explored = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: OutOfTheLoopTheme.dark,
          locale: const Locale('pt', 'BR'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: CategorySelectionScreen(
            repository: repository,
            language: SupportedLanguage.ptBr,
            packsController: packs,
            onContinue: (category) => selected = category,
            onExplorePacks: () => explored = true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Para jogar'), findsOneWidget);
      final tiles = find.byType(OtlCategoryTile);
      expect(tiles, findsNWidgets(7));
      final first = tester.getRect(tiles.at(0));
      final second = tester.getRect(tiles.at(1));
      expect(first.height, 112);
      expect(first.top, second.top);
      expect(first.right, lessThan(second.left));
      expect(find.text('EN'), findsOneWidget);
      final owned = find.text((await catalog.load()).first.title);
      await tester.ensureVisible(owned);
      await tester.tap(owned);
      expect(selected?.id, 'us_backyard');
      final explore = find.text('Explorar pacotes');
      await tester.scrollUntilVisible(
        explore,
        160,
        scrollable: find
            .descendant(
              of: find.descendant(
                of: find.byType(CategorySelectionScreen),
                matching: find.byType(ListView),
              ),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.tap(explore);
      expect(explored, isTrue);

      gateway.entitlements = {UsPackCatalog.bundleId};
      await packs.refresh(restore: true);
      await tester.pumpAndSettle();
      expect(tiles, findsNWidgets(9));
      expect(find.text('EN'), findsNWidgets(3));
      gateway.entitlements = {};
      await packs.refresh();
      await tester.pumpAndSettle();
      expect(tiles, findsNWidgets(6));
      expect(find.text('EN'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'owned pack starts from Portuguese discovery with English content and store returns to library',
    (tester) async {
      final flow = GameFlowController(
        repository: repository,
        usPackCatalog: catalog,
        packAccess: packs.owns,
      )..language = SupportedLanguage.ptBr;
      final sounds = SoundEffectsService();
      final music = BackgroundMusicService();
      final appRouter = AppRouter(
        flow: flow,
        packs: packs,
        preferencesRepository: const PreferencesRepository(),
        soundEffects: sounds,
        backgroundMusic: music,
        onFlowChanged: () {},
      );
      addTearDown(appRouter.router.dispose);
      addTearDown(sounds.dispose);
      addTearDown(music.dispose);
      await tester.pumpWidget(
        MaterialApp.router(
          theme: OutOfTheLoopTheme.dark,
          locale: const Locale('pt', 'BR'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: appRouter.router,
        ),
      );
      appRouter.router.go(AppRoutes.categories);
      await tester.pumpAndSettle();
      final explore = find.text('Explorar pacotes');
      await tester.scrollUntilVisible(
        explore,
        160,
        scrollable: find
            .descendant(
              of: find.descendant(
                of: find.byType(CategorySelectionScreen),
                matching: find.byType(ListView),
              ),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.tap(explore);
      await tester.pumpAndSettle();
      expect(find.byType(PacksScreen), findsOneWidget);
      appRouter.router.pop();
      await tester.pumpAndSettle();
      final owned = find.text((await catalog.load()).first.title);
      await tester.ensureVisible(owned);
      await tester.tap(owned);
      await tester.pumpAndSettle();
      expect(find.byType(MatchSetupScreen), findsOneWidget);
      expect(flow.selectedCategory?.id, 'us_backyard');
      expect(flow.categoryWords, hasLength(20));
      expect(flow.language, SupportedLanguage.ptBr);
      expect(tester.takeException(), isNull);
    },
  );
}
