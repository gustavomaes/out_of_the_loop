import 'dart:ui' show ViewFocusDirection, ViewFocusEvent, ViewFocusState;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/classic/classic_content_repository.dart';
import 'package:outoftheloop/src/domain/classic/classic_models.dart';
import 'package:outoftheloop/src/domain/classic/classic_round_factory.dart';
import 'package:outoftheloop/src/features/classic/application/classic_controller.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_app.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_home.dart';
import 'classic_round_test.dart' show FixedRandom;

ClassicController game({
  int count = 3,
  bool troll = false,
  bool hint = false,
  int? timer,
  Duration Function()? now,
}) => ClassicController(
  content: const ClassicContentRepository(),
  config: ClassicConfig(
    players: List.generate(
      count,
      (i) => ClassicPlayer(id: '$i', name: 'Player $i'),
    ),
    categoryIds: {'food'},
    troll: troll,
    hint: hint,
    timerMinutes: timer,
  ),
  factory: ClassicRoundFactory(random: FixedRandom()),
  now: now,
);
Future<void> tap(WidgetTester t, Finder f) async {
  await t.ensureVisible(f);
  await t.pumpAndSettle();
  await t.tap(f);
  await t.pumpAndSettle();
}

Finder button(String label) => find.widgetWithText(ElevatedButton, label);
Future<void> role(WidgetTester t) async {
  await tap(t, find.byKey(const Key('accessible-reveal')));
  expect(find.text('Hide role'), findsOneWidget);
  expect(
    t
        .widget<ElevatedButton>(
          find.descendant(
            of: find.byKey(const Key('next-player')),
            matching: find.byType(ElevatedButton),
          ),
        )
        .onPressed,
    isNull,
  );
  await tap(t, find.byKey(const Key('accessible-reveal')));
  await tap(
    t,
    find.descendant(
      of: find.byKey(const Key('next-player')),
      matching: find.byType(ElevatedButton),
    ),
  );
}

void main() {
  for (final count in [3, 20]) {
    testWidgets(
      'complete $count player game, confirmation cancel, result, double replay and edit',
      (t) async {
        t.view.physicalSize = const Size(320, 640);
        t.view.devicePixelRatio = 1;
        addTearDown(t.view.resetPhysicalSize);
        addTearDown(t.view.resetDevicePixelRatio);
        final c = game(count: count);
        addTearDown(c.dispose);
        await t.pumpWidget(
          ClassicApp(
            textScaler: const TextScaler.linear(2),
            home: ClassicHome(controller: c),
          ),
        );
        await t.tap(button('Start game'));
        await t.tap(button('Start game'));
        await t.pumpAndSettle();
        expect(c.history.rounds, 1);
        final first = c.round!.id;
        for (var i = 0; i < count; i++) {
          expect(find.text(c.round!.word.text), findsNothing);
          await role(t);
        }
        expect(c.phase, ClassicPhase.discussion);
        expect(find.byKey(const Key('discussion-timer')), findsNothing);
        expect(find.text(c.round!.word.text), findsNothing);
        await tap(t, button('Reveal result'));
        await t.tap(find.text('Cancel'));
        await t.pumpAndSettle();
        expect(c.phase, ClassicPhase.discussion);
        await tap(t, button('Reveal result'));
        await t.tap(find.widgetWithText(TextButton, 'Reveal result'));
        await t.pumpAndSettle();
        expect(c.phase, ClassicPhase.result);
        expect(find.text(c.round!.word.text), findsOneWidget);
        for (final p in c.round!.config.players.where(
          (p) => c.round!.impostorIds.contains(p.id),
        )) {
          expect(find.text(p.name), findsOneWidget);
        }
        await t.ensureVisible(button('Play again'));
        await t.pumpAndSettle();
        await t.tap(button('Play again'));
        await t.tap(button('Play again'));
        await t.pumpAndSettle();
        expect(c.history.rounds, 2);
        expect(c.round!.id, isNot(first));
        expect(find.text(c.round!.word.text), findsNothing);
        for (var i = 0; i < count; i++) {
          await role(t);
        }
        c.revealResult();
        await t.pumpAndSettle();
        await tap(t, find.text('Edit game'));
        expect(c.phase, ClassicPhase.home);
        expect(c.config.players.length, count);
        expect(t.takeException(), isNull);
      },
    );
  }
  testWidgets(
    'hold/release/cancel/outside; no role or gesture inherited by next player',
    (t) async {
      final c = game();
      addTearDown(c.dispose);
      await t.pumpWidget(ClassicApp(home: ClassicHome(controller: c)));
      await t.tap(button('Start game'));
      await t.pumpAndSettle();
      Finder card() =>
          find.byKey(ValueKey('role-card-${c.round!.id}-${c.revealIndex}'));
      var gesture = await t.startGesture(t.getCenter(card()), pointer: 7);
      await t.pump();
      expect(find.text('You’re an impostor'), findsOneWidget);
      await gesture.up();
      await t.pump();
      expect(find.text('You’re an impostor'), findsNothing);
      gesture = await t.startGesture(t.getCenter(card()));
      await t.pump();
      await gesture.cancel();
      await t.pump();
      expect(find.text('You’re an impostor'), findsNothing);
      gesture = await t.startGesture(t.getCenter(card()), pointer: 8);
      await t.pump();
      await gesture.moveBy(const Offset(500, 0));
      await t.pump();
      expect(find.text('You’re an impostor'), findsNothing);
      expect(c.viewed, isTrue, reason: 'role has been seen');
      await gesture.up();
      await t.pump();
      await tap(t, button('Next player'));
      expect(c.revealIndex, 1);
      expect(find.text(c.round!.word.text), findsNothing);
      expect(c.viewed, isFalse);
      expect(t.widget<ElevatedButton>(button('Next player')).onPressed, isNull);
      await tap(t, find.byKey(const Key('accessible-reveal')));
      expect(find.text(c.round!.word.text), findsOneWidget);
    },
  );
  testWidgets(
    'background and focus hide, require fresh viewing; exit cancels without revealing',
    (t) async {
      final c = game();
      addTearDown(c.dispose);
      await t.pumpWidget(ClassicApp(home: ClassicHome(controller: c)));
      await t.tap(button('Start game'));
      await t.pumpAndSettle();
      await tap(t, find.byKey(const Key('accessible-reveal')));
      final id = c.round!.id;
      t.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      await t.pump();
      expect(find.text('You’re an impostor'), findsNothing);
      t.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await t.pumpAndSettle();
      expect(c.round!.id, id);
      expect(c.viewed, isFalse);
      expect(find.text('Hide role'), findsNothing);
      await tap(t, find.byKey(const Key('accessible-reveal')));
      t.binding.handleViewFocusChanged(
        ViewFocusEvent(
          viewId: t.view.viewId,
          state: ViewFocusState.unfocused,
          direction: ViewFocusDirection.undefined,
        ),
      );
      await t.pump();
      expect(find.text('You’re an impostor'), findsNothing);
      t.binding.handleViewFocusChanged(
        ViewFocusEvent(
          viewId: t.view.viewId,
          state: ViewFocusState.focused,
          direction: ViewFocusDirection.undefined,
        ),
      );
      await t.pumpAndSettle();
      await tap(t, find.byKey(const Key('accessible-reveal')));
      await t.tap(find.byTooltip('End round'));
      await t.pumpAndSettle();
      expect(find.text('You’re an impostor'), findsNothing);
      await t.tap(find.text('Cancel'));
      await t.pumpAndSettle();
      expect(c.phase, ClassicPhase.revealing);
      expect(find.text('Hide role'), findsNothing);
      await t.binding.handlePopRoute();
      await t.pumpAndSettle();
      await t.tap(find.widgetWithText(TextButton, 'End round'));
      await t.pumpAndSettle();
      expect(c.phase, ClassicPhase.home);
      expect(c.round, isNull);
    },
  );
  testWidgets('accessible role hides when keyboard focus leaves its control', (
    t,
  ) async {
    final c = game();
    addTearDown(c.dispose);
    await t.pumpWidget(ClassicApp(home: ClassicHome(controller: c)));
    await t.tap(button('Start game'));
    await t.pumpAndSettle();
    final reveal = find.byKey(const Key('accessible-reveal'));
    Focus.of(t.element(reveal)).requestFocus();
    await t.pump();
    await tap(t, reveal);
    expect(find.text('You’re an impostor'), findsOneWidget);
    FocusManager.instance.primaryFocus!.unfocus();
    await t.pumpAndSettle();
    expect(find.text('You’re an impostor'), findsNothing);
    expect(find.text('Hide role'), findsNothing);
  });
  testWidgets(
    'Troll roles hide all words; hint frozen; result explicitly labels everyone',
    (t) async {
      final c = game(troll: true, hint: true);
      addTearDown(c.dispose);
      await t.pumpWidget(ClassicApp(home: ClassicHome(controller: c)));
      await t.tap(button('Start game'));
      await t.pumpAndSettle();
      for (var i = 0; i < 3; i++) {
        await tap(t, find.byKey(const Key('accessible-reveal')));
        expect(find.text('You’re an impostor'), findsOneWidget);
        expect(find.text('Food & Drinks'), findsOneWidget);
        expect(find.text(c.round!.word.text), findsNothing);
        expect(find.text('Troll round — everyone!'), findsNothing);
        await tap(t, find.byKey(const Key('accessible-reveal')));
        await tap(t, button(i == 2 ? 'Start discussion' : 'Next player'));
      }
      await tap(t, button('Reveal result'));
      await t.tap(find.widgetWithText(TextButton, 'Reveal result'));
      await t.pumpAndSettle();
      expect(find.text('Troll round — everyone!'), findsOneWidget);
      expect(find.text(c.round!.word.text), findsOneWidget);
      for (final p in c.config.players) {
        expect(find.text(p.name), findsOneWidget);
      }
    },
  );
  testWidgets('timer zero stays discussion and background freezes remaining', (
    t,
  ) async {
    var time = Duration.zero;
    final c = game(timer: 1, now: () => time);
    addTearDown(c.dispose);
    await t.pumpWidget(ClassicApp(home: ClassicHome(controller: c)));
    await t.tap(button('Start game'));
    await t.pumpAndSettle();
    for (var i = 0; i < 3; i++) {
      await role(t);
    }
    expect(find.text('1:00'), findsOneWidget);
    time += const Duration(seconds: 10);
    await t.pump(const Duration(seconds: 1));
    expect(find.text('0:50'), findsOneWidget);
    t.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    t.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await t.pumpAndSettle();
    time += const Duration(minutes: 2);
    await t.pump(const Duration(seconds: 1));
    expect(find.text('0:50'), findsOneWidget);
    await tap(t, find.text('Resume timer'));
    time += const Duration(minutes: 1);
    await t.pump(const Duration(seconds: 1));
    expect(find.text('0:00'), findsOneWidget);
    expect(c.phase, ClassicPhase.discussion);
    expect(find.text(c.round!.word.text), findsNothing);
  });
}
