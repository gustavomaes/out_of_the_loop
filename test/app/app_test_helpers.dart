import 'package:shared_preferences/shared_preferences.dart';

/// Pins app integration tests to English copy and stable discovery labels.
void setEnglishAppPreferences() {
  SharedPreferences.setMockInitialValues({'settings.language': 'en'});
}
