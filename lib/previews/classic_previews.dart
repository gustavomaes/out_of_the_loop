import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import '../src/features/classic/presentation/classic_dev_app.dart';

@Preview(name: 'Coral Social / 320', group: 'Classic', size: Size(320, 640))
Widget classicSmallPreview() => const ClassicDevApp();

@Preview(
  name: 'Coral Social / text 200%',
  group: 'Classic',
  size: Size(320, 640),
)
Widget classicLargeTextPreview() =>
    const ClassicDevApp(textScaler: TextScaler.linear(2));

@Preview(
  name: 'Coral Social / components',
  group: 'Classic',
  size: Size(320, 640),
)
Widget classicComponentsPreview() =>
    const ClassicDevApp(home: ClassicGallery());
