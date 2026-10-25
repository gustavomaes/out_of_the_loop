import 'classic_gallery.dart';
import '../src/features/classic/application/classic_experience.dart';
import '../src/features/classic/presentation/classic_settings.dart';
import '../src/features/premium/premium_access.dart';
import '../src/features/premium/premium_sheet.dart';
import '../src/data/purchases/purchase_gateway.dart';
import 'dart:convert';
import '../src/data/classic/classic_session_repository.dart';
import '../src/features/classic/presentation/classic_session_host.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import '../src/features/classic/presentation/classic_app.dart';
import '../src/features/classic/presentation/classic_home.dart';
import '../src/features/classic/application/classic_controller.dart';
import '../src/domain/classic/classic_models.dart';
import '../src/data/classic/classic_content_repository.dart';

@Preview(name: 'Coral Social / 320', group: 'Classic', size: Size(320, 640))
Widget classicSmallPreview() => const ClassicApp();

@Preview(
  name: 'Coral Social / text 200%',
  group: 'Classic',
  size: Size(320, 640),
)
Widget classicLargeTextPreview() =>
    const ClassicApp(textScaler: TextScaler.linear(2));

@Preview(
  name: 'Coral Social / components',
  group: 'Classic',
  size: Size(320, 640),
)
Widget classicComponentsPreview() => const ClassicApp(home: ClassicGallery());

@Preview(name: 'Classic / private role', group: 'Classic', size: Size(320, 640))
Widget classicRolePreview() => const ClassicApp(home: _RoundPreview());

@Preview(name: 'Classic / discussion', group: 'Classic', size: Size(320, 640))
Widget classicDiscussionPreview() =>
    const ClassicApp(home: _RoundPreview(discussion: true));

class _RoundPreview extends StatefulWidget {
  const _RoundPreview({this.discussion = false});
  final bool discussion;
  @override
  State<_RoundPreview> createState() => _RoundPreviewState();
}

class _RoundPreviewState extends State<_RoundPreview> {
  late final controller = ClassicController(
    content: const ClassicContentRepository(),
    config: ClassicConfig(
      players: const [
        ClassicPlayer(id: '1', name: 'Alex'),
        ClassicPlayer(id: '2', name: 'Sam'),
        ClassicPlayer(id: '3', name: 'Robin'),
      ],
      categoryIds: {'food'},
      timerMinutes: 3,
    ),
  );
  @override
  void initState() {
    super.initState();
    controller.start();
    if (widget.discussion) {
      for (var i = 0; i < 3; i++) {
        controller.markViewed(i);
        controller.nextPlayer(i);
      }
      controller.pauseTimer();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ClassicHome(controller: controller);
}

@Preview(name: 'Classic / resume 200%', group: 'Classic', size: Size(320, 640))
Widget classicResumePreview() => _sessionPreview(false);

@Preview(
  name: 'Classic / recovery 200%',
  group: 'Classic',
  size: Size(320, 640),
)
Widget classicRecoveryPreview() => _sessionPreview(true);

Widget _sessionPreview(bool corrupt) {
  final c = ClassicController(
    content: const ClassicContentRepository(),
    config: ClassicConfig(
      players: const [
        ClassicPlayer(id: '1', name: 'Alex'),
        ClassicPlayer(id: '2', name: 'Sam'),
        ClassicPlayer(id: '3', name: 'Robin'),
      ],
      categoryIds: {'food'},
    ),
  );
  c.start();
  String? raw = corrupt ? '{broken' : jsonEncode(c.session.toJson());
  c.dispose();
  return ClassicApp(
    textScaler: const TextScaler.linear(2),
    home: ClassicSessionHost(
      repository: ClassicSessionRepository(
        read: (_) async => raw,
        write: (_, value) async {
          raw = value;
        },
      ),
    ),
  );
}

@Preview(
  name: 'Premium / store unavailable / 200%',
  group: 'Classic',
  size: Size(320, 640),
)
Widget classicPremiumPreview() =>
    const ClassicApp(textScaler: TextScaler.linear(2), home: _PremiumPreview());

class _PremiumPreview extends StatefulWidget {
  const _PremiumPreview();
  @override
  State<_PremiumPreview> createState() => _PremiumPreviewState();
}

class _PremiumPreviewState extends State<_PremiumPreview> {
  late final access = PremiumAccess(
    gateway: _PreviewPurchases(),
    entitlement: 'preview',
  );
  @override
  void dispose() {
    access.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: PremiumSheet(access: access),
      ),
    ),
  );
}

class _PreviewPurchases implements PurchaseGateway {
  @override
  Future<PurchaseSnapshot> load({bool restore = false}) async =>
      const PurchaseSnapshot();
  @override
  Future<PurchaseOutcome> buy(String id) async => PurchaseOutcome.unavailable;
}

@Preview(
  name: 'Classic / Arabic RTL 200%',
  group: 'Classic',
  size: Size(768, 1024),
)
Widget classicArabicPreview() =>
    const ClassicApp(locale: Locale('ar'), textScaler: TextScaler.linear(2));

@Preview(
  name: 'Classic / settings 200%',
  group: 'Classic',
  size: Size(320, 640),
)
Widget classicSettingsPreview() => const _SettingsPreview();

class _SettingsPreview extends StatefulWidget {
  const _SettingsPreview();
  @override
  State<_SettingsPreview> createState() => _SettingsPreviewState();
}

class _SettingsPreviewState extends State<_SettingsPreview> {
  final experience = ClassicExperience(persist: false);
  @override
  void dispose() {
    experience.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ClassicApp(
    experience: experience,
    textScaler: const TextScaler.linear(2),
    home: const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(24), child: ClassicSettings()),
        ),
      ),
    ),
  );
}
