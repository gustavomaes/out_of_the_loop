import 'package:flutter/material.dart';

import 'src/app/firebase_bootstrap.dart';
import 'src/app/out_of_the_loop_app.dart';

Future<void> main() async {
  await bootstrapFirebase();
  runApp(const OutOfTheLoopApp());
}
