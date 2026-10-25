import 'package:flutter/material.dart';
import 'src/features/classic/presentation/classic_dev_app.dart';

/// Explicit offline entry: no Firebase, purchases, preferences or network bootstrap.
void main() => runApp(const ClassicDevApp());
