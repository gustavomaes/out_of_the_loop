import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/features/classic/presentation/classic_dev_app.dart';
import 'src/features/classic/presentation/classic_session_host.dart';

/// Classic entry: offline gameplay; optional RevenueCat configuration from build defines.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Locale? locale;
  try {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('settings.language');
    if (code != null) {
      final parts = code.split('-');
      locale = Locale(parts.first, parts.length > 1 ? parts[1] : null);
    }
  } on Object {
    // The host presents storage recovery; a preference failure cannot block boot.
  }
  runApp(ClassicDevApp(locale: locale, home: const ClassicSessionHost()));
}
