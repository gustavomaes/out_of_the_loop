import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/content/us_pack_catalog.dart';
import '../../data/purchases/purchase_gateway.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../shared/widgets/otl_neon_action.dart';
import '../../theme/theme.dart';
import '../setup/category_icon.dart';
import 'packs_controller.dart';

class PacksScreen extends StatefulWidget {
  const PacksScreen({
    required this.controller,
    required this.onPlay,
    this.onBack,
    super.key,
  });
  final PacksController controller;
  final ValueChanged<GameNightPack> onPlay;
  final VoidCallback? onBack;
  @override
  State<PacksScreen> createState() => _PacksScreenState();
}

class _PacksScreenState extends State<PacksScreen> {
  String? _message;
  @override
  void initState() {
    super.initState();
    unawaited(widget.controller.refresh());
    unawaited(widget.controller.analytics.logPackEvent('pack_shop_viewed'));
  }

  Future<void> _buy(String id) async {
    final outcome = await widget.controller.buy(id);
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    setState(
      () => _message = switch (outcome) {
        PurchaseOutcome.purchased => l10n.purchaseSuccess,
        PurchaseOutcome.pending => l10n.purchasePending,
        PurchaseOutcome.cancelled => null,
        PurchaseOutcome.unavailable => l10n.packUnavailable,
        PurchaseOutcome.failed => l10n.purchaseFailed,
      },
    );
  }

  Future<void> _restore() async {
    await widget.controller.refresh(restore: true);
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    setState(
      () => _message = widget.controller.loadFailed
          ? l10n.purchaseFailed
          : widget.controller.snapshot.available
          ? l10n.purchaseRestored
          : l10n.packUnavailable,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = widget.controller;
    return Scaffold(
      appBar: OtlBrutalistAppBar(
        title: l10n.gameNightPacks,
        onBack: widget.onBack,
      ),
      body: SafeArea(
        top: false,
        child: OtlContentWidth(
          child: ListenableBuilder(
            listenable: c,
            builder: (context, _) => ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              children: [
                Text(
                  l10n.gameNightPacks,
                  style: DisplayTypography.rubikPlayerSetupTitle(
                    color: BrutalistColors.cardText,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.packsSubtitle,
                  style: DisplayTypography.plusJakartaBody(
                    color: BrutalistColors.sectionLabel,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                if (c.busy)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (!c.snapshot.available && !c.busy)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      l10n.packUnavailable,
                      style: DisplayTypography.plusJakartaBody(
                        color: BrutalistColors.sectionLabel,
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (_message != null)
                  Semantics(
                    liveRegion: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        _message!,
                        style: DisplayTypography.plusJakartaBody(
                          color: BrutalistColors.cardText,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                for (final pack in c.packs)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: OtlBrutalistSurface(
                      backgroundColor: BrutalistColors.cardBackground,
                      shadowOffset: 0,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            categoryIconFor(pack.category.iconKey),
                            color: Color(pack.category.primaryArgb),
                            size: 36,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            pack.title,
                            style: DisplayTypography.rubikTitle(
                              color: BrutalistColors.cardText,
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            pack.description,
                            style: DisplayTypography.plusJakartaBody(
                              color: BrutalistColors.sectionLabel,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.packWordCount(pack.content.words.length),
                            style: DisplayTypography.spaceGroteskMeta(
                              color: BrutalistColors.sectionLabel,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (c.owns(pack.id))
                            OtlNeonAction(
                              label: l10n.packPlay,
                              onPressed: c.busy
                                  ? null
                                  : () => widget.onPlay(pack),
                            )
                          else ...[
                            if (c.snapshot.offers[pack.id] case final offer?)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  offer.price,
                                  style: DisplayTypography.rubikTitle(
                                    color: BrutalistColors.lime,
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                            OtlNeonAction(
                              label: l10n.packBuy,
                              onPressed:
                                  c.busy ||
                                      !c.snapshot.offers.containsKey(pack.id)
                                  ? null
                                  : () => _buy(pack.id),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              l10n.packPurchaseOnce,
                              style: DisplayTypography.plusJakartaBody(
                                color: BrutalistColors.sectionLabel,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                if (!c.snapshot.entitlements.contains(UsPackCatalog.bundleId) &&
                    c.snapshot.offers.containsKey(UsPackCatalog.bundleId))
                  OtlBrutalistSurface(
                    backgroundColor: BrutalistColors.cardBackground,
                    shadowOffset: 0,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l10n.packBundleTitle,
                          style: DisplayTypography.rubikTitle(
                            color: BrutalistColors.cardText,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.packBundleDescription,
                          style: DisplayTypography.plusJakartaBody(
                            color: BrutalistColors.sectionLabel,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          c.snapshot.offers[UsPackCatalog.bundleId]!.price,
                          style: DisplayTypography.rubikTitle(
                            color: BrutalistColors.lime,
                          ),
                        ),
                        const SizedBox(height: 14),
                        OtlNeonAction(
                          label: l10n.packBuy,
                          onPressed: c.busy
                              ? null
                              : () => _buy(UsPackCatalog.bundleId),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.packPurchaseOnce,
                          style: DisplayTypography.plusJakartaBody(
                            color: BrutalistColors.sectionLabel,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 14),
                OtlNeonAction(
                  label: l10n.restorePurchases,
                  primary: false,
                  onPressed: c.busy ? null : _restore,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
