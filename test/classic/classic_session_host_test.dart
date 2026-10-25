import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:outoftheloop/src/data/classic/classic_session_repository.dart';
import 'package:outoftheloop/src/data/classic/classic_content_repository.dart';
import 'package:outoftheloop/src/domain/classic/classic_models.dart';
import 'package:outoftheloop/src/features/classic/application/classic_controller.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_app.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_session_host.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));
  testWidgets('cold launch prompts, resumes covered, and saves each player', (
    t,
  ) async {
    final initial = ClassicController(
      content: const ClassicContentRepository(),
      config: ClassicConfig(
        players: const [
          ClassicPlayer(id: 'a', name: 'Ana'),
          ClassicPlayer(id: 'b', name: 'Bia'),
          ClassicPlayer(id: 'c', name: 'Caio'),
        ],
        categoryIds: {'food'},
      ),
    );
    initial.start();
    final secret = initial.round!.word.text;
    String? raw = jsonEncode(initial.session.toJson());
    final repo = ClassicSessionRepository(
      read: (_) async => raw,
      write: (_, value) async {
        raw = value;
      },
    );
    initial.dispose();
    await t.pumpWidget(ClassicApp(home: ClassicSessionHost(repository: repo)));
    await t.pumpAndSettle();
    expect(find.text('Game in progress'), findsOneWidget);
    expect(find.text(secret), findsNothing);
    await t.tap(find.text('Resume game'));
    await t.pumpAndSettle();
    expect(find.text(secret), findsNothing);
    final next = find.text('Next player');
    expect(
      t
          .widget<ElevatedButton>(
            find
                .ancestor(of: next, matching: find.byType(ElevatedButton))
                .first,
          )
          .onPressed,
      null,
    );
    await t.ensureVisible(find.byKey(const Key('accessible-reveal')));
    await t.tap(find.byKey(const Key('accessible-reveal')));
    await t.pumpAndSettle();
    await t.tap(find.byKey(const Key('accessible-reveal')));
    await t.pumpAndSettle();
    await t.ensureVisible(next);
    await t.tap(next);
    await t.pumpAndSettle();
    expect((jsonDecode(raw!) as Map)['snapshot']['index'], 1);
    expect(find.text(secret), findsNothing);
    // Replace the entire widget tree: no surviving controller can supply state.
    await t.pumpWidget(const SizedBox());
    await t.pumpWidget(ClassicApp(home: ClassicSessionHost(repository: repo)));
    await t.pumpAndSettle();
    expect(find.text('Game in progress'), findsOneWidget);
    await t.tap(find.text('End round'));
    await t.pumpAndSettle();
    expect(
      find.text(
        'Discard only the saved round? Your group, history, settings and purchases will stay.',
      ),
      findsOneWidget,
    );
    await t.tap(find.text('Confirm'));
    await t.pumpAndSettle();
    expect((jsonDecode(raw!) as Map)['snapshot'], null);
    expect((jsonDecode(raw!) as Map)['config']['players'][0]['name'], 'Ana');
    await t.pumpWidget(const SizedBox());
  });
  testWidgets(
    'unknown schema offers explicit temporary game and preserves save',
    (t) async {
      const raw = '{"version":99}';
      var writes = 0;
      final repo = ClassicSessionRepository(
        read: (_) async => raw,
        write: (_, _) async {
          writes++;
        },
      );
      await t.pumpWidget(
        ClassicApp(home: ClassicSessionHost(repository: repo)),
      );
      await t.pumpAndSettle();
      expect(find.text('Saved game recovery'), findsOneWidget);
      await t.tap(find.text('New game'));
      await t.pumpAndSettle();
      await t.tap(find.text('Confirm'));
      await t.pumpAndSettle();
      expect(
        find.text('Progress is not saved. Reopening may lose recent progress.'),
        findsOneWidget,
      );
      expect(writes, 0);
      await t.pumpWidget(const SizedBox());
    },
  );
  testWidgets('write failure requires retry or explicit unsaved continuation', (
    t,
  ) async {
    var fail = true;
    String? raw;
    final repo = ClassicSessionRepository(
      read: (_) async => raw,
      write: (_, value) async {
        if (fail) throw StateError('injected');
        raw = value;
      },
    );
    await t.pumpWidget(ClassicApp(home: ClassicSessionHost(repository: repo)));
    await t.pumpAndSettle();
    await t.tap(find.text('Start game'));
    await t.pumpAndSettle();
    expect(find.text('Saved game recovery'), findsOneWidget);
    expect(raw, null);
    await t.tap(find.text('Continue without saving'));
    await t.pumpAndSettle();
    expect(
      find.text('Progress is not saved. Reopening may lose recent progress.'),
      findsOneWidget,
    );
    await t.ensureVisible(find.byKey(const Key('accessible-reveal')));
    await t.tap(find.byKey(const Key('accessible-reveal')));
    await t.pumpAndSettle();
    await t.tap(find.byKey(const Key('accessible-reveal')));
    await t.pumpAndSettle();
    fail = false;
    await t.ensureVisible(find.text('Next player'));
    await t.tap(find.text('Next player'));
    await t.pumpAndSettle();
    expect((jsonDecode(raw!) as Map)['snapshot']['index'], 1);
    expect(
      find.text('Progress is not saved. Reopening may lose recent progress.'),
      findsNothing,
    );
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('resume and recovery fit 320px at text 200 percent', (t) async {
    await t.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => t.binding.setSurfaceSize(null));
    final repo = ClassicSessionRepository(
      read: (_) async => '{corrupt',
      write: (_, _) async {},
    );
    await t.pumpWidget(
      ClassicApp(
        textScaler: const TextScaler.linear(2),
        home: ClassicSessionHost(repository: repo),
      ),
    );
    await t.pumpAndSettle();
    await t.scrollUntilVisible(
      find.text('New game'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(t.takeException(), null);
    await t.pumpWidget(const SizedBox());
  });
}
