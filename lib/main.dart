import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/app/firebase_bootstrap.dart';
import 'src/app/out_of_the_loop_app.dart';

Future<void> main() async {
  await bootstrapFirebase();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const OutOfTheLoopApp());
}
