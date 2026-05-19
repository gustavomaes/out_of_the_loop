import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/about_card.dart';
import 'widgets/audio_toggle_row.dart';
import 'widgets/language_selector.dart';
import 'widgets/settings_section.dart';
import 'widgets/timer_settings_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    this.initialLanguage = SupportedLanguage.ptBr,
    this.initialTimerSettings = const TimerSettings(),
    this.initialMusicEnabled = false,
    this.initialSoundEffectsEnabled = true,
    this.onLanguageChanged,
    this.onTimerChanged,
    this.onMusicEnabledChanged,
    this.onSoundEffectsEnabledChanged,
    this.onTermsOfUseTap,
    this.onPrivacyTap,
    super.key,
  });

  final SupportedLanguage initialLanguage;
  final TimerSettings initialTimerSettings;
  final bool initialMusicEnabled;
  final bool initialSoundEffectsEnabled;
  final ValueChanged<SupportedLanguage>? onLanguageChanged;
  final ValueChanged<TimerSettings>? onTimerChanged;
  final ValueChanged<bool>? onMusicEnabledChanged;
  final ValueChanged<bool>? onSoundEffectsEnabledChanged;
  final VoidCallback? onTermsOfUseTap;
  final VoidCallback? onPrivacyTap;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SupportedLanguage _language = widget.initialLanguage;
  late TimerSettings _timerSettings = widget.initialTimerSettings;
  late bool _musicEnabled = widget.initialMusicEnabled;
  late bool _soundEffectsEnabled = widget.initialSoundEffectsEnabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BrutalistScreenTheme.wrap(
      context,
      AppShell(
        routeName: AppRoutes.settings,
        title: l10n.settings,
        appBar: OtlBrutalistAppBar(title: l10n.settingsScreenTitle),
        bodyPadding: EdgeInsets.zero,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            SettingsSection(
              label: l10n.settingsSectionLanguage,
              child: LanguageSelector(
                label: _languageLabel(l10n, _language),
                onTap: () => _showLanguagePicker(context, l10n),
              ),
            ),
            const SizedBox(height: 24),
            SettingsSection(
              label: l10n.settingsSectionAudio,
              child: Column(
                children: [
                  AudioToggleRow(
                    icon: Icons.music_note,
                    iconColor: BrutalistColors.settingsMusicIcon,
                    label: l10n.settingsMusic,
                    value: _musicEnabled,
                    onChanged: (value) {
                      setState(() => _musicEnabled = value);
                      widget.onMusicEnabledChanged?.call(value);
                    },
                  ),
                  const SizedBox(height: 12),
                  AudioToggleRow(
                    icon: Icons.volume_up,
                    iconColor: BrutalistColors.settingsSfxIcon,
                    label: l10n.settingsSoundEffects,
                    value: _soundEffectsEnabled,
                    onChanged: (value) {
                      setState(() => _soundEffectsEnabled = value);
                      widget.onSoundEffectsEnabledChanged?.call(value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SettingsSection(
              label: l10n.settingsSectionTimer,
              child: TimerSettingsCard(
                enabled: _timerSettings.enabled,
                durationSeconds: _timerSettings.durationSeconds,
                useTimerLabel: l10n.settingsUseTimer,
                durationLabel: l10n.settingsTimerSeconds(
                  _timerSettings.durationSeconds,
                ),
                onEnabledChanged: (enabled) => _updateTimer(
                  TimerSettings(
                    enabled: enabled,
                    durationSeconds: _timerSettings.durationSeconds,
                  ),
                ),
                onDurationChanged: (seconds) => _updateTimer(
                  TimerSettings(
                    enabled: _timerSettings.enabled,
                    durationSeconds: seconds,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SettingsSection(
              label: l10n.settingsSectionAbout,
              child: AboutCard(
                termsLabel: l10n.settingsTermsOfUse,
                privacyLabel: l10n.settingsPrivacy,
                versionLabel: l10n.settingsAppVersionLabel,
                versionValue: l10n.settingsAppVersionValue,
                onTermsTap: widget.onTermsOfUseTap,
                onPrivacyTap: widget.onPrivacyTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateTimer(TimerSettings settings) {
    setState(() => _timerSettings = settings);
    widget.onTimerChanged?.call(settings);
  }

  Future<void> _showLanguagePicker(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final selected = await showModalBottomSheet<SupportedLanguage>(
      context: context,
      backgroundColor: BrutalistColors.cardBackground,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 4),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final language in SupportedLanguage.values)
                ListTile(
                  title: Text(
                    _languageLabel(l10n, language),
                    style: DisplayTypography.rubikSettingLabel(
                      color: BrutalistColors.cardText,
                    ),
                  ),
                  trailing: language == _language
                      ? const Icon(Icons.check, color: BrutalistColors.lime)
                      : null,
                  onTap: () => Navigator.of(context).pop(language),
                ),
            ],
          ),
        );
      },
    );

    if (selected == null || selected == _language) {
      return;
    }

    setState(() => _language = selected);
    widget.onLanguageChanged?.call(selected);
  }

  String _languageLabel(AppLocalizations l10n, SupportedLanguage language) {
    return switch (language) {
      SupportedLanguage.ptBr => l10n.settingsLanguagePortuguese,
      SupportedLanguage.en => l10n.settingsLanguageEnglish,
      SupportedLanguage.es => l10n.settingsLanguageSpanish,
      SupportedLanguage.hi => l10n.settingsLanguageHindi,
    };
  }
}
