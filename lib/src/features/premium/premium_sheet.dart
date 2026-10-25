import '../../l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'premium_access.dart';

class PremiumSheet extends StatelessWidget {
  const PremiumSheet({super.key, required this.access});
  final PremiumAccess access;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: access,
    builder: (context, _) {
      final l = AppLocalizations.of(context)!;
      final messages = {
        'No purchases found.': l.premiumNone,
        'Purchases restored.': l.premiumRestored,
        'Unable to refresh purchases. Please retry.': l.premiumRefreshError,
        'Premium is active.': l.premiumActive,
        'Purchase awaiting access verification. Restore or retry.':
            l.premiumVerifying,
        'Purchase cancelled.': l.premiumCancelled,
        'Payment pending approval.': l.premiumPending,
        'Purchase unavailable. Please retry.': l.premiumBuyError,
        'Purchase could not be verified. Restore or retry.':
            l.premiumVerifyError,
      };
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l.premiumSummary),
          Text(l.premiumRenewal),
          if (access.enabled) Text(l.premiumActive),
          if (!access.enabled)
            for (final offer in access.snapshot.offers.values.where(
              (o) => o.period == 'P1Y' || o.period == 'P1W',
            ))
              FilledButton(
                onPressed: access.busy ? null : () => access.buy(offer.id),
                child: Text(
                  '${offer.period == 'P1Y' ? l.premiumAnnual : l.premiumWeekly} · ${offer.price}',
                ),
              ),
          if (!access.enabled && access.snapshot.offers.isEmpty)
            Text(l.premiumUnavailable),
          if (access.busy) const LinearProgressIndicator(),
          if (access.message != null)
            Text(messages[access.message] ?? l.premiumVerifyError),
          TextButton(
            onPressed: access.busy ? null : () => access.refresh(restore: true),
            child: Text(l.premiumRestore),
          ),
          TextButton(
            onPressed: access.busy ? null : () => access.refresh(),
            child: Text(l.classicRetry),
          ),
          for (final entry in {
            l.premiumTerms: const String.fromEnvironment('CLASSIC_TERMS_URL'),
            l.settingsPrivacy: const String.fromEnvironment(
              'CLASSIC_PRIVACY_URL',
            ),
          }.entries)
            if (Uri.tryParse(entry.value)?.scheme == 'https')
              TextButton(
                onPressed: () => launchUrl(
                  Uri.parse(entry.value),
                  mode: LaunchMode.externalApplication,
                ),
                child: Text(entry.key),
              ),
          TextButton(
            onPressed: () => launchUrl(
              Uri.parse('https://apps.apple.com/account/subscriptions'),
              mode: LaunchMode.externalApplication,
            ),
            child: Text(l.premiumManage),
          ),
        ],
      );
    },
  );
}
