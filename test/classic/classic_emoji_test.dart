import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/classic/classic_content_repository.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_emoji.dart';

void main() {
  final emojis = {
    for (final category in classicCategories) category.emoji,
    '👥',
    '🗂️',
    '🥷',
    '💡',
    '⏱️',
    '😈',
  };

  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'every category and control emoji has a decodable bundled image',
    () async {
      for (final emoji in emojis) {
        final bytes = await rootBundle.load(ClassicEmojiLabel.assetFor(emoji));
        final codec = await ui.instantiateImageCodec(
          bytes.buffer.asUint8List(),
        );
        final frame = await codec.getNextFrame();
        expect(frame.image.width, 72, reason: emoji);
        expect(frame.image.height, 72, reason: emoji);
        frame.image.dispose();
        codec.dispose();
      }
    },
  );

  for (final direction in TextDirection.values) {
    testWidgets(
      'emoji labels wrap at 200% with $direction and decorative images',
      (t) async {
        t.view.physicalSize = const Size(320, 640);
        t.view.devicePixelRatio = 1;
        addTearDown(t.view.resetPhysicalSize);
        addTearDown(t.view.resetDevicePixelRatio);
        await t.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(2)),
              child: Directionality(
                textDirection: direction,
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final emoji in emojis)
                          ClassicEmojiLabel(
                            emoji: emoji,
                            label: 'A long category name that wraps',
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        await t.pumpAndSettle();
        expect(t.takeException(), isNull);
        expect(find.byType(Image), findsNWidgets(emojis.length));
        for (final image in t.widgetList<Image>(find.byType(Image))) {
          expect(image.excludeFromSemantics, isTrue);
          expect(image.width, greaterThan(14));
        }
      },
    );
  }
}
