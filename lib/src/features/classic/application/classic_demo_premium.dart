import '../../premium/premium_access.dart';
import '../../../data/purchases/purchase_gateway.dart';

/// Offline development fake; never used by the executable session host.
class ClassicDemoPremium extends PremiumAccess {
  ClassicDemoPremium({bool enabled = false})
    : _enabled = enabled,
      super(gateway: _DemoGateway(), entitlement: 'demo');
  bool _enabled;
  @override
  bool get enabled => _enabled;
  void enable() {
    _enabled = true;
    notifyListeners();
  }
}

class _DemoGateway implements PurchaseGateway {
  @override
  Future<PurchaseSnapshot> load({bool restore = false}) async =>
      const PurchaseSnapshot();
  @override
  Future<PurchaseOutcome> buy(String id) async => PurchaseOutcome.unavailable;
}
