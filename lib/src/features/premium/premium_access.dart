import 'package:flutter/foundation.dart';
import '../../data/purchases/purchase_gateway.dart';

/// Rights are derived only from SDK snapshots, never persisted as a local grant.
class PremiumAccess extends ChangeNotifier {
  PremiumAccess({
    required this.gateway,
    required this.entitlement,
    this.legacyCategories = const {},
  });
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
    busy = true;
    message = null;
    notifyListeners();
    try {
      snapshot = await gateway.load(restore: restore);
      if (restore) {
        message = snapshot.entitlements.isEmpty
            ? 'No purchases found.'
            : 'Purchases restored.';
      }
    } on Object {
      // A network error cannot revoke a previously validated cached SDK snapshot.
      message = 'Unable to refresh purchases. Please retry.';
    } finally {
      busy = false;
      if (!_disposed) notifyListeners();
    }
  }

  Future<void> buy(String id) async {
    if (busy) return;
    busy = true;
    message = null;
    notifyListeners();
    try {
      final outcome = await gateway.buy(id);
      if (outcome == PurchaseOutcome.purchased) {
        snapshot = await gateway.load();
        message = enabled
            ? 'Premium is active.'
            : 'Purchase awaiting access verification. Restore or retry.';
      } else {
        message = switch (outcome) {
          PurchaseOutcome.cancelled => 'Purchase cancelled.',
          PurchaseOutcome.pending => 'Payment pending approval.',
          _ => 'Purchase unavailable. Please retry.',
        };
      }
    } on Object {
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
