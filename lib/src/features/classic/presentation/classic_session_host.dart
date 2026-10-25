import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../data/purchases/purchase_gateway.dart';
import '../../../data/purchases/classic_billing_config.dart';
import '../../premium/premium_access.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/classic/classic_content_repository.dart';
import '../../../data/classic/classic_session_repository.dart';
import '../../../data/classic/classic_legacy_migration.dart';
import '../../../domain/classic/classic_models.dart';
import '../../../domain/classic/classic_round_factory.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/classic_controller.dart';
import 'classic_components.dart';
import 'classic_home.dart';

/// Storage is initialized only for the executable entry; widget previews stay isolated.
class ClassicSessionHost extends StatefulWidget {
  const ClassicSessionHost({super.key, this.repository});
  final ClassicSessionRepository? repository;
  @override
  State<ClassicSessionHost> createState() => _ClassicSessionHostState();
}

class _ClassicSessionHostState extends State<ClassicSessionHost>
    with WidgetsBindingObserver {
  static const entitlement = String.fromEnvironment(
    'CLASSIC_PREMIUM_ENTITLEMENT',
  );
  late final premium = PremiumAccess(
    entitlement: entitlement,
    legacyCategories: classicLegacyRights(
      const String.fromEnvironment(
        'CLASSIC_LEGACY_RIGHTS_JSON',
        defaultValue: '{}',
      ),
    ),
    gateway: RevenueCatPurchaseGateway(
      includeLegacyOffers: false,
      subscriptionProducts: {
        if (const String.fromEnvironment('CLASSIC_ANNUAL_PRODUCT') != '' &&
            entitlement != '')
          const String.fromEnvironment('CLASSIC_ANNUAL_PRODUCT'): entitlement,
        if (const String.fromEnvironment('CLASSIC_WEEKLY_PRODUCT') != '' &&
            entitlement != '')
          const String.fromEnvironment('CLASSIC_WEEKLY_PRODUCT'): entitlement,
      },
    ),
  );
  void customerChanged(CustomerInfo _) {
    premium.refresh();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) premium.refresh();
  }

  ClassicSessionRepository? repository;
  ClassicController? controller;
  bool loading = true;
  bool loadError = false;
  bool futureSchema = false;
  bool resumePrompt = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Purchases.addCustomerInfoUpdateListener(customerChanged);
    premium.refresh();
    load();
  }

  Future<void> load() async {
    setState(() => loading = true);
    try {
      repository ??= widget.repository ?? await ClassicSessionRepository.open();
      final prefs = widget.repository == null
          ? await SharedPreferences.getInstance()
          : null;
      final fallback = ClassicSession(
        config: ClassicConfig(
          players: const [
            ClassicPlayer(id: '1', name: 'Alex'),
            ClassicPlayer(id: '2', name: 'Sam'),
            ClassicPlayer(id: '3', name: 'Robin'),
          ],
          categoryIds: {'food', 'animals', 'sports'},
        ),
        history: ClassicHistory(),
        // Keep the existing preference keys authoritative for Guided/Classic.
        preferences: {
          for (final key in [
            'settings.language',
            'settings.music',
            'settings.soundEffects',
          ])
            if (prefs?.get(key) != null) key: prefs!.get(key)!,
        },
      );
      final result = await repository!.load(
        fallback,
        migrate: (data) => migrateClassicLegacy(data, fallback),
      );
      if (!mounted) return;
      controller?.dispose();
      controller = ClassicController(
        content: const ClassicContentRepository(),
        categoryAllowed: (id) => premium.allows(
          id,
          free: classicCategories.any((c) => c.id == id && !c.premium),
        ),
        config: result.session.config,
        restored: result.session,
        // Future schemas stay untouched if the user chooses a temporary game.
        repository: result.future ? null : repository,
      );
      setState(() {
        loadError = result.issue;
        futureSchema = result.future;
        resumePrompt = result.session.round != null;
        loading = false;
      });
    } on Object {
      if (mounted) {
        setState(() {
          loading = false;
          loadError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Purchases.removeCustomerInfoUpdateListener(customerChanged);
    premium.dispose();
    controller?.dispose();
    super.dispose();
  }

  Future<bool> confirm(String title, String body) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(AppLocalizations.of(context)!.classicConfirm),
            ),
          ],
        ),
      ) ??
      false;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (loadError) {
      return page(l.classicRecoveryTitle, [
        Text(futureSchema ? l.classicFutureSave : l.classicRecoveryBody),
        ClassicButton(label: l.classicRetry, onPressed: load),
        if (controller != null)
          ClassicButton(
            label: l.classicNewGame,
            onPressed: () async {
              if (!await confirm(l.classicNewGame, l.classicDiscardBody) ||
                  !mounted) {
                return;
              }
              setState(() => loadError = false);
              // Only a user-confirmed recovery may replace a damaged current schema.
              if (!futureSchema) await controller!.flush();
            },
          ),
      ]);
    }
    final c = controller!;
    return ListenableBuilder(
      listenable: c,
      builder: (context, _) {
        if (resumePrompt) {
          return page(l.classicResumeTitle, [
            Text(l.classicResumeBody),
            ClassicButton(
              label: l.classicResumeGame,
              onPressed: () => setState(() => resumePrompt = false),
            ),
            ClassicButton(
              label: l.classicEnd,
              onPressed: () async {
                if (!await confirm(l.classicEnd, l.classicDiscardBody) ||
                    !mounted) {
                  return;
                }
                c.endRound();
                setState(() => resumePrompt = false);
              },
            ),
          ]);
        }
        return Stack(
          children: [
            Column(
              children: [
                if (c.persistenceError || futureSchema)
                  Material(
                    color: CoralTokens.surface,
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(l.classicUnsavedNotice),
                      ),
                    ),
                  ),
                Expanded(
                  child: ClassicHome(controller: c, premium: premium),
                ),
              ],
            ),
            if (c.saving)
              const Positioned.fill(
                child: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              ),
            if (!c.saving && c.persistenceError && !c.continuingWithoutSave)
              Positioned.fill(
                child: page(l.classicRecoveryTitle, [
                  Text(l.classicWriteFailure),
                  ClassicButton(label: l.classicRetry, onPressed: c.flush),
                  ClassicButton(
                    label: l.classicContinueUnsaved,
                    onPressed: c.continueWithoutSave,
                  ),
                ]),
              ),
          ],
        );
      },
    );
  }

  Widget page(String title, List<Widget> children) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: SafeArea(
      child: ListView(padding: const EdgeInsets.all(24), children: children),
    ),
  );
}
