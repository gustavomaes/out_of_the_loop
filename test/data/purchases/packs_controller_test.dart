import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/content/us_pack_catalog.dart';
import 'package:outoftheloop/src/data/purchases/purchase_gateway.dart';
import 'package:outoftheloop/src/features/packs/packs_controller.dart';
import 'package:outoftheloop/src/app/game_flow_controller.dart';
import 'package:outoftheloop/src/domain/models/models.dart';

class FakePurchaseGateway implements PurchaseGateway {
  PurchaseOutcome outcome = PurchaseOutcome.purchased;
  Set<String> rights = {};
  bool grantOnPurchase = true;
  bool throwOnLoad = false;
  int purchases = 0;
  bool restored = false;
  static const offer = PackOffer(
    id: 'us_backyard',
    price: '\$2.99',
    currencyCode: 'USD',
    amount: 2.99,
  );
  @override
  Future<PurchaseSnapshot> load({bool restore = false}) async {
    if (throwOnLoad) throw StateError('offline');
    restored = restore;
    return PurchaseSnapshot(
      available: true,
      entitlements: Set.of(rights),
      offers: {'us_backyard': offer},
    );
  }

  @override
  Future<PurchaseOutcome> buy(String id) async {
    purchases++;
    if (outcome == PurchaseOutcome.purchased && grantOnPurchase) rights.add(id);
    return outcome;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late UsPackCatalog catalog;
  setUp(
    () => catalog = UsPackCatalog(
      seedJson: File('assets/content/us_game_night.json').readAsStringSync(),
    ),
  );
  test(
    'US packs have unique IDs and 60 English words with 9 non-leaking prompts each',
    () async {
      final packs = await catalog.load();
      expect(packs.map((p) => p.id), UsPackCatalog.ids);
      final words = packs.expand((p) => p.content.words).toList();
      expect(words, hasLength(60));
      expect(words.map((w) => w.id).toSet(), hasLength(60));
      for (final word in words) {
        expect(word.questions, hasLength(9));
        for (final q in word.questions) {
          expect(
            q.text
                .valueFor(SupportedLanguage.en)
                .toLowerCase()
                .contains(
                  word.value.valueFor(SupportedLanguage.en).toLowerCase(),
                ),
            isFalse,
            reason: word.id,
          );
        }
      }
    },
  );
  test(
    'no API key means unavailable store without calling platform plugins',
    () async {
      final snapshot = await RevenueCatPurchaseGateway().load();
      expect(snapshot.available, isFalse);
      expect(snapshot.entitlements, isEmpty);
    },
  );
  test(
    'cancelled, pending and failed transactions never grant a pack',
    () async {
      for (final outcome in [
        PurchaseOutcome.cancelled,
        PurchaseOutcome.pending,
        PurchaseOutcome.failed,
      ]) {
        final gateway = FakePurchaseGateway()..outcome = outcome;
        final controller = PacksController(gateway: gateway, catalog: catalog);
        await controller.refresh();
        expect(await controller.buy('us_backyard'), outcome);
        expect(controller.owns('us_backyard'), isFalse);
        controller.dispose();
      }
    },
  );
  test(
    'a purchase result alone cannot grant access without a confirmed entitlement',
    () async {
      final gateway = FakePurchaseGateway()..grantOnPurchase = false;
      final controller = PacksController(gateway: gateway, catalog: catalog);
      await controller.refresh();
      expect(await controller.buy('us_backyard'), PurchaseOutcome.failed);
      expect(controller.owns('us_backyard'), isFalse);
      controller.dispose();
    },
  );
  test(
    'confirmed purchase and collection restore unlock only valid rights',
    () async {
      final gateway = FakePurchaseGateway();
      final controller = PacksController(gateway: gateway, catalog: catalog);
      await controller.refresh();
      expect(await controller.buy('us_backyard'), PurchaseOutcome.purchased);
      expect(controller.owns('us_backyard'), isTrue);
      expect(controller.owns('us_roadtrip'), isFalse);
      gateway.rights = {UsPackCatalog.bundleId};
      await controller.refresh(restore: true);
      expect(gateway.restored, isTrue);
      expect(UsPackCatalog.ids.every(controller.owns), isTrue);
      gateway.rights = {};
      await controller.refresh();
      expect(controller.owns('us_backyard'), isFalse);
      controller.dispose();
    },
  );
  test(
    'premium content is rejected at the controller boundary when locked',
    () async {
      final pack = (await catalog.load()).first;
      final locked = GameFlowController(usPackCatalog: catalog);
      expect(() => locked.selectCategory(pack.category), throwsStateError);
      final owned = GameFlowController(
        usPackCatalog: catalog,
        packAccess: (_) => true,
      );
      await owned.selectCategory(pack.category);
      expect(owned.categoryWords, hasLength(20));
      owned.language = SupportedLanguage.es;
      expect(() => owned.selectCategory(pack.category), throwsStateError);
    },
  );
}
