import 'package:flutter/foundation.dart';

/// Offline demonstration only. Never persisted or used by the production entry.
class ClassicDemoPremium extends ChangeNotifier {
  ClassicDemoPremium({bool enabled = false}) : _enabled = enabled;
  bool _enabled;
  bool get enabled => _enabled;
  void enable() {
    _enabled = true;
    notifyListeners();
  }
}
