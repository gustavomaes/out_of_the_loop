import 'package:outoftheloop/src/data/purchases/purchase_gateway.dart';

class CategoryPurchaseGateway implements PurchaseGateway {
  CategoryPurchaseGateway([this.entitlements = const {}]);
  Set<String> entitlements;

  @override
  Future<PurchaseSnapshot> load({bool restore = false}) async =>
      PurchaseSnapshot(available: true, entitlements: Set.of(entitlements));

  @override
  Future<PurchaseOutcome> buy(String id) async => PurchaseOutcome.unavailable;
}
