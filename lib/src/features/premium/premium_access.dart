import '../../data/analytics/classic_analytics.dart';
import 'package:flutter/foundation.dart';
import '../../data/purchases/purchase_gateway.dart';

/// Rights are derived only from SDK snapshots, never persisted as a local grant.
class PremiumAccess extends ChangeNotifier {
  PremiumAccess({
    required this.gateway,
    required this.entitlement,
    this.legacyCategories = const {},
    ClassicAnalytics? analytics,
  }) : analytics = analytics ?? ClassicAnalytics();
  final ClassicAnalytics analytics;
  ClassicOrigin origin = ClassicOrigin.home;
  final PurchaseGateway gateway;
  final String entitlement;

  /// Audited entitlement → Classic category IDs. Empty until audit is supplied.
  final Map<String, Set<String>> legacyCategories;
  PurchaseSnapshot snapshot = const PurchaseSnapshot();
  bool busy = false;
  String? message;
  bool _disposed = false;
  bool get enabled =>
      entitlement.isNotEmpty && snapshot.entitlements.contains(entitlement);
  bool allows(String id, {required bool free}) =>
      free ||
      enabled ||
      legacyCategories.entries.any(
        (entry) =>
            snapshot.entitlements.contains(entry.key) &&
            entry.value.contains(id),
      );
  Future<void> refresh({bool restore = false}) async {
    if (busy) return;
    if (restore) {
      analytics.record(ClassicEvent.restoreRequested, origin: origin);
    }
    busy = true;
    message = null;
    notifyListeners();
    try {
      final loaded = await gateway.load(restore: restore);
      if (!setEquals(snapshot.entitlements, loaded.entitlements)) {
        analytics.record(ClassicEvent.entitlementChanged);
      }
      snapshot = loaded;
      if (restore) {
        analytics.record(
          snapshot.entitlements.isEmpty
              ? ClassicEvent.restoreEmpty
              : ClassicEvent.restoreFound,
          origin: origin,
        );
        message = snapshot.entitlements.isEmpty
            ? 'No purchases found.'
            : 'Purchases restored.';
      }
    } on Object {
      if (restore) analytics.record(ClassicEvent.restoreFailed, origin: origin);
      // A network error cannot revoke a previously validated cached SDK snapshot.
      message = 'Unable to refresh purchases. Please retry.';
    } finally {
      busy = false;
      if (!_disposed) notifyListeners();
    }
  }

  Future<void> buy(String id) async {
    if (busy) return;
    final plan = switch (snapshot.offers[id]?.period) {
      'P1Y' => ClassicPlan.annual,
      'P1W' => ClassicPlan.weekly,
      _ => null,
    };
    final source = origin;
    analytics.record(ClassicEvent.planSelected, origin: source, plan: plan);
    analytics.record(
      ClassicEvent.purchaseRequested,
      origin: source,
      plan: plan,
    );
    busy = true;
    message = null;
    notifyListeners();
    try {
      final outcome = await gateway.buy(id);
      if (outcome == PurchaseOutcome.purchased) {
        snapshot = await gateway.load();
        analytics.record(
          enabled
              ? ClassicEvent.purchaseVerified
              : ClassicEvent.purchasePending,
          origin: source,
          plan: plan,
        );
        message = enabled
            ? 'Premium is active.'
            : 'Purchase awaiting access verification. Restore or retry.';
      } else {
        analytics.record(
          switch (outcome) {
            PurchaseOutcome.cancelled => ClassicEvent.purchaseCancelled,
            PurchaseOutcome.pending => ClassicEvent.purchasePending,
            _ => ClassicEvent.purchaseFailed,
          },
          origin: source,
          plan: plan,
        );
        message = switch (outcome) {
          PurchaseOutcome.cancelled => 'Purchase cancelled.',
          PurchaseOutcome.pending => 'Payment pending approval.',
          _ => 'Purchase unavailable. Please retry.',
        };
      }
    } on Object {
      analytics.record(ClassicEvent.purchaseFailed, origin: source, plan: plan);
      message = 'Purchase could not be verified. Restore or retry.';
    } finally {
      busy = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
