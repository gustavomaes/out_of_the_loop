import 'package:outoftheloop/src/features/classic/presentation/classic_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:outoftheloop/src/features/premium/premium_sheet.dart';
import 'package:outoftheloop/src/data/purchases/classic_billing_config.dart';
import 'package:outoftheloop/src/data/purchases/purchase_gateway.dart';
import 'package:outoftheloop/src/features/premium/premium_access.dart';

class BillingFake implements PurchaseGateway {
  PurchaseSnapshot value = const PurchaseSnapshot();
  PurchaseOutcome outcome = PurchaseOutcome.purchased;
  bool fail = false;
  @override
  Future<PurchaseSnapshot> load({bool restore = false}) async {
    if (fail) throw StateError('offline');
    return value;
  }

  @override
  Future<PurchaseOutcome> buy(String id) async => outcome;
}

void main() {
  testWidgets(
    'store price, pending, restore empty and active management states',
    (t) async {
      final gateway = BillingFake()
        ..value = const PurchaseSnapshot(
          offers: {
            'week': PackOffer(
              id: 'week',
              price: 'R\$ 7,90',
              currencyCode: 'BRL',
              amount: 7.9,
              period: 'P1W',
            ),
          },
        )
        ..outcome = PurchaseOutcome.pending;
      final access = PremiumAccess(gateway: gateway, entitlement: 'premium');
      addTearDown(access.dispose);
      await access.refresh();
      await t.pumpWidget(
        ClassicApp(
          home: Scaffold(
            body: SingleChildScrollView(child: PremiumSheet(access: access)),
          ),
        ),
      );
      await t.tap(find.text('Weekly · R\$ 7,90'));
      await t.pumpAndSettle();
      expect(find.text('Payment pending approval.'), findsOneWidget);
      expect(access.enabled, isFalse);
      await t.tap(find.text('Restore purchases'));
      await t.pumpAndSettle();
      expect(find.text('No purchases found.'), findsOneWidget);
      gateway.value = const PurchaseSnapshot(entitlements: {'premium'});
      await access.refresh();
      await t.pumpAndSettle();
      expect(find.text('Premium is active.'), findsOneWidget);
      expect(find.text('Manage subscription'), findsOneWidget);
      expect(find.text('Weekly · R\$ 7,90'), findsNothing);
    },
  );

  test(
    'annual and weekly products map to same entitlement independently of package',
    () {
      for (final product in ['annual.store', 'weekly.store']) {
        expect(
          purchaseEntitlement(
            packageId: 'rc-package',
            productId: product,
            subscriptions: {
              'annual.store': 'premium',
              'weekly.store': 'premium',
            },
            packages: {'old-package': 'legacy'},
          ),
          'premium',
        );
      }
      expect(
        purchaseEntitlement(
          packageId: 'old-package',
          productId: 'old.store',
          subscriptions: {},
          packages: {'old-package': 'legacy'},
        ),
        'legacy',
      );
      expect(
        purchaseEntitlement(
          packageId: 'unknown',
          productId: 'unknown',
          subscriptions: {},
          packages: {},
        ),
        isNull,
      );
    },
  );
  test(
    'SDK rights survive network failure; successful revocation removes access',
    () async {
      final gateway = BillingFake()
        ..value = const PurchaseSnapshot(entitlements: {'premium'});
      final access = PremiumAccess(gateway: gateway, entitlement: 'premium');
      addTearDown(access.dispose);
      await access.refresh();
      expect(access.enabled, isTrue);
      gateway.fail = true;
      await access.refresh();
      expect(access.enabled, isTrue);
      gateway.fail = false;
      gateway.value = const PurchaseSnapshot();
      await access.refresh();
      expect(access.enabled, isFalse);
    },
  );
  test(
    'pending/cancelled/failed and unverified success never grant rights',
    () async {
      final gateway = BillingFake();
      final access = PremiumAccess(gateway: gateway, entitlement: 'premium');
      addTearDown(access.dispose);
      for (final outcome in PurchaseOutcome.values) {
        gateway.outcome = outcome;
        await access.buy('annual');
        expect(access.enabled, isFalse);
        expect(access.busy, isFalse);
      }
      gateway.value = const PurchaseSnapshot(entitlements: {'premium'});
      gateway.outcome = PurchaseOutcome.purchased;
      await access.buy('weekly');
      expect(access.enabled, isTrue);
    },
  );
  test(
    'audited legacy rights grant only their categories; restore distinguishes empty',
    () async {
      final gateway = BillingFake()
        ..value = const PurchaseSnapshot(entitlements: {'old'});
      final access = PremiumAccess(
        gateway: gateway,
        entitlement: 'premium',
        legacyCategories: classicLegacyRights('{"old":["movies"]}'),
      );
      addTearDown(access.dispose);
      await access.refresh(restore: true);
      expect(access.allows('movies', free: false), isTrue);
      expect(access.allows('food', free: true), isTrue);
      expect(access.allows('music', free: false), isFalse);
      expect(access.enabled, isFalse);
      gateway.value = const PurchaseSnapshot();
      await access.refresh(restore: true);
      expect(access.message, 'No purchases found.');
      expect(classicLegacyRights('{broken'), isEmpty);
    },
  );
}
