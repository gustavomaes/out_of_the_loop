import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PackOffer {
  const PackOffer({
    required this.id,
    required this.price,
    required this.currencyCode,
    required this.amount,
  });
  final String id;
  final String price;
  final String currencyCode;
  final double amount;
}

class PurchaseSnapshot {
  const PurchaseSnapshot({
    this.entitlements = const {},
    this.offers = const {},
    this.available = false,
  });
  final Set<String> entitlements;
  final Map<String, PackOffer> offers;
  final bool available;
}

enum PurchaseOutcome { purchased, cancelled, pending, failed, unavailable }

abstract interface class PurchaseGateway {
  Future<PurchaseSnapshot> load({bool restore = false});
  Future<PurchaseOutcome> buy(String id);
}

/// Product/entitlement IDs are app configuration, never an invented store price.
/// No SDK calls or external requests happen unless a platform public key is set.
class RevenueCatPurchaseGateway implements PurchaseGateway {
  static const _iosKey = String.fromEnvironment('REVENUECAT_IOS_API_KEY');
  static const _androidKey = String.fromEnvironment(
    'REVENUECAT_ANDROID_API_KEY',
  );
  final Map<String, Package> _packages = {};
  bool _configured = false;
  String get _key => kIsWeb
      ? ''
      : switch (defaultTargetPlatform) {
          TargetPlatform.iOS => _iosKey,
          TargetPlatform.android => _androidKey,
          _ => '',
        };
  Future<bool> _configure() async {
    if (_key.isEmpty) return false;
    if (!_configured) {
      final config = PurchasesConfiguration(_key)
        ..entitlementVerificationMode =
            EntitlementVerificationMode.informational;
      await Purchases.configure(config);
      _configured = true;
    }
    return true;
  }

  Set<String> _active(CustomerInfo info) =>
      info.entitlements.verification == VerificationResult.failed
      ? {}
      : info.entitlements.active.keys.toSet();
  @override
  Future<PurchaseSnapshot> load({bool restore = false}) async {
    if (!await _configure()) return const PurchaseSnapshot();
    final customer = restore
        ? await Purchases.restorePurchases()
        : await Purchases.getCustomerInfo();
    final entitlements = _active(customer);
    _packages.clear();
    // Offline entitlements from the SDK remain usable if fetching offers fails.
    try {
      final offerings = await Purchases.getOfferings();
      for (final package
          in offerings.current?.availablePackages ?? <Package>[]) {
        if (package.storeProduct.productCategory ==
                ProductCategory.nonSubscription &&
            package.storeProduct.subscriptionPeriod == null) {
          _packages[package.identifier] = package;
        }
      }
    } on Object {
      /* Existing purchased packs still work offline. */
    }
    return PurchaseSnapshot(
      available: true,
      entitlements: entitlements,
      offers: {
        for (final entry in _packages.entries)
          entry.key: PackOffer(
            id: entry.key,
            price: entry.value.storeProduct.priceString,
            currencyCode: entry.value.storeProduct.currencyCode,
            amount: entry.value.storeProduct.price,
          ),
      },
    );
  }

  @override
  Future<PurchaseOutcome> buy(String id) async {
    final package = _packages[id];
    if (package == null || !await _configure()) {
      return PurchaseOutcome.unavailable;
    }
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      return _active(result.customerInfo).contains(id)
          ? PurchaseOutcome.purchased
          : PurchaseOutcome.failed;
    } on PlatformException catch (error) {
      return switch (PurchasesErrorHelper.getErrorCode(error)) {
        PurchasesErrorCode.purchaseCancelledError => PurchaseOutcome.cancelled,
        PurchasesErrorCode.paymentPendingError => PurchaseOutcome.pending,
        _ => PurchaseOutcome.failed,
      };
    } on Object {
      return PurchaseOutcome.failed;
    }
  }
}
