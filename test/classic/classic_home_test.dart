import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/classic/classic_content_repository.dart';
import 'package:outoftheloop/src/domain/classic/classic_models.dart';
import 'package:outoftheloop/src/features/classic/application/classic_controller.dart';
import 'package:outoftheloop/src/features/classic/application/classic_demo_premium.dart';
import 'package:outoftheloop/src/features/premium/premium_access.dart';
import 'package:outoftheloop/src/data/purchases/purchase_gateway.dart';
import 'premium_access_test.dart' show BillingFake;
import 'package:outoftheloop/src/features/classic/presentation/classic_app.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_home.dart';

ClassicController makeController([int count = 3]) => ClassicController(
  content: const ClassicContentRepository(),
  config: ClassicConfig(
    players: List.generate(
      count,
      (i) => ClassicPlayer(id: '$i', name: 'Player ${i + 1}'),
    ),
    categoryIds: {'food', 'animals', 'sports'},
  ),
);
Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      160,
      scrollable: find.byType(BottomSheet).evaluate().isEmpty
          ? find.byType(Scrollable).first
          : find
                .descendant(
                  of: find.byType(BottomSheet).last,
                  matching: find.byType(Scrollable),
                )
                .first,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'category draft cancels, Clear disables Confirm, free selects three',
    (t) async {
      final c = makeController();
      addTearDown(c.dispose);
      await t.pumpWidget(ClassicApp(home: ClassicHome(controller: c)));
      await tapVisible(t, find.byKey(const Key('edit-categories')));
      await t.tap(find.text('Clear'));
      await t.pumpAndSettle();
      expect(
        t
            .widget<ElevatedButton>(
              find.widgetWithText(ElevatedButton, 'Confirm'),
            )
            .onPressed,
        isNull,
      );
      await t.tap(find.byTooltip('Close'));
      await t.pumpAndSettle();
      expect(c.config.categoryIds.length, 3);
      await tapVisible(t, find.byKey(const Key('edit-categories')));
      await t.tap(find.text('Select all free'));
      await t.pumpAndSettle();
      expect(
        t
            .widget<CheckboxListTile>(find.byKey(const Key('category-food')))
            .value,
        isTrue,
      );
      await t.tap(find.text('Confirm'));
      await t.pumpAndSettle();
      expect(c.config.categoryIds, {'food', 'animals', 'sports'});
      expect(find.text('All'), findsNothing);
    },
  );
  testWidgets(
    'contextual store purchase preserves draft until Confirm and unlocks all 23',
    (t) async {
      final c = makeController();
      final gateway = BillingFake()
        ..value = const PurchaseSnapshot(
          offers: {
            'annual': PackOffer(
              id: 'annual',
              price: '\$19.99',
              currencyCode: 'USD',
              amount: 19.99,
              productId: 'annual.store',
              period: 'P1Y',
            ),
          },
        );
      final p = PremiumAccess(gateway: gateway, entitlement: 'premium');
      await p.refresh();
      addTearDown(c.dispose);
      addTearDown(p.dispose);
      await t.pumpWidget(
        ClassicApp(
          home: ClassicHome(controller: c, premium: p),
        ),
      );
      await tapVisible(t, find.byKey(const Key('edit-categories')));
      await tapVisible(t, find.byKey(const Key('category-movies')));
      gateway.value = const PurchaseSnapshot(entitlements: {'premium'});
      await tapVisible(t, find.text('Annual · \$19.99'));
      await t.tap(find.byIcon(Icons.close).last);
      await t.pumpAndSettle();
      expect(p.enabled, isTrue);
      expect(c.config.categoryIds.length, 3);
      expect(find.byType(BottomSheet), findsOneWidget);
      await t.drag(
        find
            .descendant(
              of: find.byType(BottomSheet),
              matching: find.byType(Scrollable),
            )
            .first,
        const Offset(0, 700),
      );
      await t.pumpAndSettle();
      await tapVisible(t, find.text('Select all'));
      await t.tap(find.text('Confirm'));
      await t.pumpAndSettle();
      expect(c.config.categoryIds.length, 23);
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Premium · demo'), findsNothing);
    },
  );
  testWidgets('timer switch does not open sheet and remembers duration', (
    t,
  ) async {
    final c = makeController();
    addTearDown(c.dispose);
    await t.pumpWidget(ClassicApp(home: ClassicHome(controller: c)));
    await tapVisible(t, find.byKey(const Key('edit-duration')));
    expect(find.byType(BottomSheet), findsNothing);
    await tapVisible(t, find.byKey(const Key('timer-switch')));
    expect(c.config.timerMinutes, 3);
    expect(find.byType(BottomSheet), findsNothing);
    await tapVisible(t, find.byKey(const Key('edit-duration')));
    await tapVisible(t, find.text('7 minutes'));
    expect(c.config.timerMinutes, 7);
    await t.tap(find.text('Done'));
    await t.pumpAndSettle();
    await tapVisible(t, find.byKey(const Key('timer-switch')));
    expect(c.config.timerMinutes, isNull);
    await tapVisible(t, find.byKey(const Key('timer-switch')));
    expect(c.config.timerMinutes, 7);
  });
  for (final scale in [1.0, 2.0]) {
    for (final paid in [false, true]) {
      testWidgets(
        '20 names keyboard save and dock at 320px text $scale Premium $paid',
        (t) async {
          t.view.physicalSize = const Size(320, 640);
          t.view.devicePixelRatio = 1;
          addTearDown(t.view.resetPhysicalSize);
          addTearDown(t.view.resetDevicePixelRatio);
          final c = makeController(20);
          final p = ClassicDemoPremium(enabled: paid);
          addTearDown(c.dispose);
          addTearDown(p.dispose);
          await t.pumpWidget(
            ClassicApp(
              textScaler: TextScaler.linear(scale),
              home: ClassicHome(controller: c, premium: p),
            ),
          );
          await tapVisible(t, find.byKey(const Key('edit-names')));
          final last = find.byKey(const Key('name-19'));
          await t.scrollUntilVisible(
            last,
            250,
            scrollable: find
                .descendant(
                  of: find.byType(BottomSheet),
                  matching: find.byType(Scrollable),
                )
                .first,
          );
          await t.enterText(last, 'Last edited');
          t.view.viewInsets = const FakeViewPadding(bottom: 200);
          await t.pumpAndSettle();
          final save = find.widgetWithText(ElevatedButton, 'Save names');
          expect(t.getBottomLeft(save).dy, lessThanOrEqualTo(440));
          await t.tap(save);
          await t.pumpAndSettle();
          t.view.resetViewInsets();
          await t.pumpAndSettle();
          expect(c.config.players.last.name, 'Last edited');
          final footer = find.byKey(const Key('classic-last-action'));
          await t.scrollUntilVisible(
            footer,
            250,
            scrollable: find.byType(Scrollable).first,
          );
          await t.ensureVisible(footer);
          await t.pumpAndSettle();
          expect(
            t.getBottomLeft(footer).dy,
            lessThanOrEqualTo(
              t.getTopLeft(find.byKey(const Key('classic-dock'))).dy,
            ),
          );
          expect(t.takeException(), isNull);
        },
      );
    }
  }
  testWidgets(
    'names limits, optional names and manual clamp on smaller group',
    (t) async {
      final c = makeController(4);
      c.updateConfig(c.config.copyWith(manualImpostors: 1));
      addTearDown(c.dispose);
      await t.pumpWidget(ClassicApp(home: ClassicHome(controller: c)));
      await tapVisible(t, find.byKey(const Key('edit-names')));
      await t.enterText(find.byKey(const Key('name-0')), '   ');
      await t.tap(find.byTooltip('Remove player').last);
      await t.pumpAndSettle();
      expect(
        t
            .widget<IconButton>(
              find
                  .byWidgetPredicate(
                    (w) => w is IconButton && w.tooltip == 'Remove player',
                  )
                  .first,
            )
            .onPressed,
        isNull,
      );
      await t.tap(find.text('Save names'));
      await t.pumpAndSettle();
      expect(c.config.players.length, 3);
      expect(c.config.players.first.name, 'Player 1');
      await tapVisible(t, find.byKey(const Key('edit-impostors')));
      await t.tap(find.text('Auto (recommended)'));
      await t.tap(find.text('Done'));
      await t.pumpAndSettle();
      expect(c.config.manualImpostors, isNull);
      await t.tap(find.byTooltip('How to play'));
      await t.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      Navigator.of(t.element(find.byType(BottomSheet))).pop();
      await t.pumpAndSettle();
      expect(c.config.players.length, 3);
    },
  );
  testWidgets('adding up to 20, canceling names and immediate hint/Troll', (
    t,
  ) async {
    final c = makeController(19);
    addTearDown(c.dispose);
    await t.pumpWidget(ClassicApp(home: ClassicHome(controller: c)));
    await tapVisible(t, find.byKey(const Key('edit-names')));
    final sheetScroll = find
        .descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(Scrollable),
        )
        .first;
    await t.scrollUntilVisible(
      find.text('Add player'),
      250,
      scrollable: sheetScroll,
    );
    await t.tap(find.text('Add player'));
    await t.pumpAndSettle();
    await t.scrollUntilVisible(
      find.text('Add player'),
      160,
      scrollable: sheetScroll,
    );
    await t.pumpAndSettle();
    expect(
      t
          .widget<TextButton>(find.widgetWithText(TextButton, 'Add player'))
          .onPressed,
      isNull,
    );
    await t.tap(find.byTooltip('Close'));
    await t.pumpAndSettle();
    expect(c.config.players.length, 19);
    expect(c.config.hint, isFalse);
    expect(c.config.troll, isFalse);
    await tapVisible(
      t,
      find.widgetWithText(SwitchListTile, '💡 Category hint'),
    );
    expect(c.config.hint, isTrue);
    await tapVisible(t, find.widgetWithText(SwitchListTile, '😈 Troll mode'));
    expect(c.config.troll, isTrue);
    expect(find.byType(BottomSheet), findsNothing);
  });
}
