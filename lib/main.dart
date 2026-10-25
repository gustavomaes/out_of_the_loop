import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';
import 'src/features/classic/application/classic_experience.dart';
import 'src/features/classic/presentation/classic_app.dart';
import 'src/features/classic/presentation/classic_session_host.dart';

/// Production Classic entry. Commerce and analytics never block offline play.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'Twemoji',
    ], await rootBundle.loadString('assets/emoji/LICENSE-GRAPHICS.txt'));
  });
  final experience = ClassicExperience();
  await experience.load();
  // Firebase initializes separately: offline commerce/metrics never delay free play.
  initializeClassicAnalytics();
  runApp(ClassicApp(experience: experience, home: const ClassicSessionHost()));
}

Future<void> initializeClassicAnalytics() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(!kDebugMode);
  } on Object {
    // No raw errors or crash payloads containing round state are collected.
  }
}
