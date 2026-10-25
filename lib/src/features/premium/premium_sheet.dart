import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'premium_access.dart';

class PremiumSheet extends StatelessWidget {
  const PremiumSheet({super.key, required this.access});
  final PremiumAccess access;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: access,
    builder: (context, _) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('20 extra categories · 800 additional English words'),
        const Text(
          'Annual or weekly subscription. Automatically renews unless cancelled in store settings.',
        ),
        if (access.enabled) const Text('Premium is active.'),
        if (!access.enabled)
          for (final offer in access.snapshot.offers.values.where(
            (o) => o.period == 'P1Y' || o.period == 'P1W',
          ))
            FilledButton(
              onPressed: access.busy ? null : () => access.buy(offer.id),
              child: Text(
                '${offer.period == 'P1Y' ? 'Annual' : 'Weekly'} · ${offer.price}',
              ),
            ),
        if (!access.enabled && access.snapshot.offers.isEmpty)
          const Text('Store plans unavailable. Free play remains available.'),
        if (access.busy) const LinearProgressIndicator(),
        if (access.message != null) Text(access.message!),
        TextButton(
          onPressed: access.busy ? null : () => access.refresh(restore: true),
          child: const Text('Restore purchases'),
        ),
        TextButton(
          onPressed: access.busy ? null : () => access.refresh(),
          child: const Text('Retry'),
        ),
        for (final entry in const {
          'Terms of use': String.fromEnvironment('CLASSIC_TERMS_URL'),
          'Privacy policy': String.fromEnvironment('CLASSIC_PRIVACY_URL'),
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
          child: const Text('Manage subscription'),
        ),
      ],
    ),
  );
}
