import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/features/classic/application/classic_experience.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_app.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_settings.dart';
import 'package:outoftheloop/src/features/classic/presentation/classic_home.dart';
import 'package:outoftheloop/src/features/premium/premium_sheet.dart';
import 'package:outoftheloop/src/features/premium/premium_access.dart';
import 'package:outoftheloop/src/data/purchases/purchase_gateway.dart';
import 'classic_game_flow_test.dart' show game;

void main() {
  test('all Classic and Premium keys have explicit localized values', () {
    final en =
        jsonDecode(File('lib/src/l10n/app_en.arb').readAsStringSync())
            as Map<String, dynamic>;
    for (final lang in ['pt_BR', 'es', 'hi', 'ar']) {
      final translated =
          jsonDecode(File('lib/src/l10n/app_$lang.arb').readAsStringSync())
              as Map<String, dynamic>;
      for (final key in en.keys.where(
        (k) => k.startsWith('classic') || k.startsWith('premium'),
      )) {
        expect(translated[key], isA<String>(), reason: '$lang/$key');
        expect((translated[key] as String).trim(), isNotEmpty);
      }
      for (final key in [
        'classicCrew',
        'classicHelpSteps',
        'classicHold',
        'classicWriteFailure',
        'premiumSummary',
        'premiumRenewal',
      ]) {
        expect(
          translated[key],
          isNot(en[key]),
          reason: '$lang/$key must not be an English fallback',
        );
      }
    }
  });
  for (final locale in const [
    Locale('en'),
    Locale('pt', 'BR'),
    Locale('es'),
    Locale('hi'),
    Locale('ar'),
  ]) {
    for (final size in const [Size(320, 640), Size(1024, 768)]) {
      testWidgets(
        '${locale.toLanguageTag()} $size settings/paywall 200%, RTL, private rotation',
        (t) async {
          t.view.physicalSize = size;
          t.view.devicePixelRatio = 1;
          addTearDown(t.view.resetPhysicalSize);
          addTearDown(t.view.resetDevicePixelRatio);
          final e = ClassicExperience(persist: false)..locale = locale;
          final premium = PremiumAccess(
            gateway: RevenueCatPurchaseGateway(),
            entitlement: '',
          );
          addTearDown(e.dispose);
          addTearDown(premium.dispose);
          final l = lookupAppLocalizations(locale);
          await t.pumpWidget(
            ClassicApp(
              experience: e,
              textScaler: const TextScaler.linear(2),
              home: const Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(child: ClassicSettings()),
                ),
              ),
            ),
          );
          await t.pumpAndSettle();
          expect(find.text(l.classicHaptics), findsOneWidget);
          expect(
            Directionality.of(t.element(find.byType(ClassicSettings))),
            locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          );
          await t.scrollUntilVisible(find.text(l.classicSupport), 250);
          expect(t.takeException(), isNull);
          await t.pumpWidget(
            ClassicApp(
              locale: locale,
              textScaler: const TextScaler.linear(2),
              home: Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: PremiumSheet(access: premium),
                  ),
                ),
              ),
            ),
          );
          await t.pumpAndSettle();
          expect(find.text(l.premiumSummary), findsOneWidget);
          await t.scrollUntilVisible(find.text(l.premiumManage), 250);
          expect(t.takeException(), isNull);
          final c = game();
          addTearDown(c.dispose);
          await t.pumpWidget(
            ClassicApp(
              locale: locale,
              textScaler: const TextScaler.linear(2),
              home: ClassicHome(controller: c),
            ),
          );
          await t.pumpAndSettle();
          expect(find.text(l.classicStart), findsOneWidget);
          expect(t.takeException(), isNull);
          c.start();
          await t.pumpAndSettle();
          final reveal = find.byKey(const Key('accessible-reveal'));
          await t.ensureVisible(reveal);
          await t.pumpAndSettle();
          final semantics = t.ensureSemantics();
          await t.tap(reveal);
          await t.pump();
          expect(find.text(l.classicHideRole), findsOneWidget);
          t.binding.handleMetricsChanged();
          await t.pumpAndSettle();
          expect(find.text(l.classicShowRole), findsOneWidget);
          expect(find.text(c.round!.word.text), findsNothing);
          expect(t.takeException(), isNull);
          semantics.dispose();
          await t.pumpWidget(const SizedBox.shrink());
        },
      );
    }
  }
  testWidgets(
    'changing language updates a mounted settings screen without losing game state',
    (t) async {
      final e = ClassicExperience(persist: false);
      addTearDown(e.dispose);
      await t.pumpWidget(
        ClassicApp(
          experience: e,
          home: const Scaffold(
            body: SingleChildScrollView(child: ClassicSettings()),
          ),
        ),
      );
      await t.pumpAndSettle();
      await e.change('settings.language', 'ar');
      await t.pumpAndSettle();
      expect(
        find.text(lookupAppLocalizations(const Locale('ar')).classicHaptics),
        findsOneWidget,
      );
      expect(t.takeException(), isNull);
    },
  );
}
