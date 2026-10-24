import 'package:flutter/foundation.dart';
import '../../data/content/us_pack_catalog.dart';
import '../../data/purchases/purchase_gateway.dart';
import '../../data/analytics/analytics_service.dart';

class PacksController extends ChangeNotifier {
  PacksController({
    PurchaseGateway? gateway,
    UsPackCatalog? catalog,
    AnalyticsService? analytics,
  }) : gateway = gateway ?? RevenueCatPurchaseGateway(),
       catalog = catalog ?? UsPackCatalog(),
       analytics = analytics ?? AnalyticsService();
  final PurchaseGateway gateway;
  final UsPackCatalog catalog;
  final AnalyticsService analytics;
  PurchaseSnapshot snapshot = const PurchaseSnapshot();
  List<GameNightPack> packs = const [];
  bool busy = false;
  bool loadFailed = false;
  bool _disposed = false;
  bool owns(String id) =>
      snapshot.entitlements.contains(id) ||
      snapshot.entitlements.contains(UsPackCatalog.bundleId);
  void _notify() {
    if (!_disposed) notifyListeners();
  }

  Future<void> refresh({bool restore = false}) async {
    if (busy) return;
    busy = true;
    loadFailed = false;
    _notify();
    try {
      packs = await catalog.load();
      snapshot = await gateway.load(restore: restore);
    } on Object {
      loadFailed = true;
    } finally {
      busy = false;
      _notify();
    }
  }

  Future<PurchaseOutcome> buy(String id) async {
    if (busy || snapshot.offers[id] == null) return PurchaseOutcome.unavailable;
    busy = true;
    _notify();
    final offer = snapshot.offers[id]!;
    await analytics.logPackEvent(
      'pack_purchase_started',
      packId: id,
      currency: offer.currencyCode,
      value: offer.amount,
    );
    PurchaseOutcome outcome;
    try {
      outcome = await gateway.buy(id);
      if (outcome == PurchaseOutcome.purchased) {
        snapshot = await gateway.load();
        if (!owns(id)) outcome = PurchaseOutcome.failed;
      }
    } on Object {
      outcome = PurchaseOutcome.failed;
    } finally {
      busy = false;
      _notify();
    }
    await analytics.logPackEvent(
      outcome == PurchaseOutcome.purchased
          ? 'pack_purchase_completed'
          : 'pack_purchase_${outcome.name}',
      packId: id,
      currency: offer.currencyCode,
      value: offer.amount,
    );
    return outcome;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
