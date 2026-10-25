import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/classic_experience.dart';
import 'classic_components.dart';

Future<void> classicAction(
  BuildContext context,
  Future<ClassicActionResult> Function(ClassicExperience) run,
) async {
  final experience = ClassicExperienceScope.of(context);
  if (experience == null) return;
  final result = await run(experience);
  if (!context.mounted) return;
  final l = AppLocalizations.of(context)!;
  final message = switch (result) {
    ClassicActionResult.copied => l.classicLinkCopied,
    ClassicActionResult.unavailable => l.classicActionUnavailable,
    ClassicActionResult.failed => l.classicActionFailed,
    _ => null,
  };
  if (message != null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class ClassicSettings extends StatelessWidget {
  const ClassicSettings({super.key});
  @override
  Widget build(BuildContext context) {
    final e = ClassicExperienceScope.of(context);
    final l = AppLocalizations.of(context)!;
    if (e == null) return const SizedBox.shrink();
    Future<void> change(String key, Object value) async {
      if (!await e.change(key, value) && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.classicActionFailed)));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          initialValue: Localizations.localeOf(context).languageCode == 'pt'
              ? 'pt-BR'
              : Localizations.localeOf(context).languageCode,
          isExpanded: true,
          decoration: InputDecoration(labelText: l.settingsSectionLanguage),
          items: const [
            DropdownMenuItem(value: 'en', child: Text('English')),
            DropdownMenuItem(value: 'pt-BR', child: Text('Português (Brasil)')),
            DropdownMenuItem(value: 'es', child: Text('Español')),
            DropdownMenuItem(value: 'hi', child: Text('हिन्दी')),
            DropdownMenuItem(value: 'ar', child: Text('العربية')),
          ],
          onChanged: (value) {
            if (value != null) change('settings.language', value);
          },
        ),
        ClassicSwitch(
          label: l.settingsMusic,
          value: e.musicEnabled,
          onChanged: (v) => change('settings.music', v),
        ),
        ClassicSwitch(
          label: l.settingsSoundEffects,
          value: e.soundEnabled,
          onChanged: (v) => change('settings.soundEffects', v),
        ),
        ClassicSwitch(
          label: l.classicHaptics,
          value: e.hapticsEnabled,
          onChanged: (v) => change('settings.haptics', v),
        ),
        TextButton(
          onPressed: () => classicAction(context, (e) => e.feedback()),
          child: Text(l.classicSupport),
        ),
        Text(l.classicFeedbackNotice),
        TextButton(
          onPressed: () => classicAction(context, (e) => e.review()),
          child: Text(l.classicRate),
        ),
        for (final entry in {
          l.premiumTerms: const String.fromEnvironment('CLASSIC_TERMS_URL'),
          l.settingsPrivacy: const String.fromEnvironment(
            'CLASSIC_PRIVACY_URL',
          ),
        }.entries)
          TextButton(
            onPressed: () async {
              final uri = Uri.tryParse(entry.value);
              var ok = false;
              if (uri?.scheme == 'https' && uri!.host.isNotEmpty) {
                try {
                  ok = await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                } on Object {
                  /* show safe message */
                }
              }
              if (!ok && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l.classicActionUnavailable)),
                );
              }
            },
            child: Text(entry.key),
          ),
      ],
    );
  }
}
