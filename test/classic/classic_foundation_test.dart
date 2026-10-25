import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/classic/classic_models.dart';
import 'package:outoftheloop/src/data/classic/classic_content_repository.dart';
import 'package:outoftheloop/src/features/classic/application/classic_controller.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_dev_app.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_components.dart';

ClassicConfig config(
  int count, {
  int? manual,
  int? minutes,
  Set<String>? ids,
}) => ClassicConfig(
  players: List.generate(
    count,
    (i) => ClassicPlayer(id: '$i', name: 'Player $i'),
  ),
  categoryIds: ids ?? {'food'},
  manualImpostors: manual,
  timerMinutes: minutes,
);

void main() {
  test('group, Auto boundaries, manual ceiling and timer limits', () {
    for (final n in [0, 1, 2, 21]) {
      expect(config(n).isValid, isFalse);
    }
    for (var n = 3; n <= 20; n++) {
      final c = config(n);
      expect(c.isValid, isTrue);
      expect(
        c.impostors,
        n <= 5
            ? 1
            : n <= 9
            ? 2
            : n <= 14
            ? 3
            : 4,
      );
      expect(config(n, manual: c.maximumImpostors).isValid, isTrue);
      expect(config(n, manual: c.maximumImpostors + 1).isValid, isFalse);
    }
    expect(config(3, manual: 0).isValid, isFalse);
    for (final m in [1, 3, 10]) {
      expect(config(3, minutes: m).isValid, isTrue);
    }
    for (final m in [0, 11]) {
      expect(config(3, minutes: m).isValid, isFalse);
    }
    expect(config(3, ids: {}).isValid, isFalse);
    expect(
      ClassicConfig(
        players: const [
          ClassicPlayer(id: '1', name: 'A'),
          ClassicPlayer(id: '1', name: 'B'),
          ClassicPlayer(id: '3', name: ''),
        ],
        categoryIds: {'food'},
      ).isValid,
      isFalse,
    );
  });
  test(
    'configuration freezes collections and controller rejects unknown categories',
    () {
      final c = config(3);
      expect(() => c.players.clear(), throwsUnsupportedError);
      expect(() => c.categoryIds.clear(), throwsUnsupportedError);
      final controller = ClassicController(
        content: const ClassicContentRepository(),
        config: c,
      );
      var changes = 0;
      controller.addListener(() => changes++);
      expect(controller.updateConfig(config(3, ids: {'unknown'})), isFalse);
      expect(identical(controller.config, c), isTrue);
      expect(controller.updateConfig(config(4)), isTrue);
      expect(changes, 1);
      controller.dispose();
    },
  );
  for (final scale in [1.0, 2.0]) {
    testWidgets('offline gallery at 320px and text $scale', (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(const ClassicDevApp(home: ClassicGallery()));
      expect(find.byType(ClassicCard), findsWidgets);
      await tester.tap(find.byType(Switch).first);
      await tester.pump();
      expect(tester.widget<Switch>(find.byType(Switch).first).value, isTrue);
      final sheetButton = find.byWidgetPredicate(
        (w) => w is ClassicButton && w.onPressed != null && w.error == null,
      );
      await tester.scrollUntilVisible(
        sheetButton,
        120,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.ensureVisible(sheetButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(
        find.descendant(of: sheetButton, matching: find.byType(ElevatedButton)),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(tester.takeException(), isNull);
      final closeButton = find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(ElevatedButton),
      );
      await tester.ensureVisible(closeButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(closeButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(BottomSheet), findsNothing);
      await tester.drag(find.byType(ListView), const Offset(0, -1200));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  }
}
