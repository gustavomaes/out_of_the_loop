import '../../shared/widgets/otl_neon_action.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    this.initialLanguage = SupportedLanguage.en,
    this.initialMusicEnabled = false,
    this.initialSoundEffectsEnabled = true,
    this.onLanguageChanged,
    this.onResetHistory,
    this.onForgetGroup,
    this.onOpenPacks,
    this.onMusicEnabledChanged,
    this.onSoundEffectsEnabledChanged,
    super.key,
  });

  static const privacyPolicyUrl =
      'https://mathsquirrels.com.br/politica-de-privacidade.html';

  final VoidCallback? onResetHistory;
  final VoidCallback? onForgetGroup;
  final VoidCallback? onOpenPacks;
  final SupportedLanguage initialLanguage;
  final bool initialMusicEnabled;
  final bool initialSoundEffectsEnabled;
  final ValueChanged<SupportedLanguage>? onLanguageChanged;
  final ValueChanged<bool>? onMusicEnabledChanged;
  final ValueChanged<bool>? onSoundEffectsEnabledChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SupportedLanguage _language = widget.initialLanguage;
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
        child: OtlContentWidth(
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
                label: l10n.historySection,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.historyDescription,
                      style: DisplayTypography.plusJakartaBody(
                        color: BrutalistColors.sectionLabel,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (widget.onResetHistory != null)
                      OtlNeonAction(
                        label: l10n.resetHistory,
                        primary: false,
                        onPressed: () {
                          widget.onResetHistory!();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.historyReset)),
                          );
                        },
                      ),
                    if (widget.onForgetGroup != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: OtlNeonAction(
                          label: l10n.forgetGroup,
                          primary: false,
                          onPressed: () {
                            widget.onForgetGroup!();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.groupForgotten)),
                            );
                          },
                        ),
                      ),
                    if (widget.onOpenPacks != null &&
                        _language == SupportedLanguage.en)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: OtlNeonAction(
                          label: l10n.gameNightPacks,
                          primary: false,
                          onPressed: widget.onOpenPacks,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SettingsSection(
                label: l10n.settingsSectionAbout,
                child: AboutCard(
                  privacyLabel: l10n.settingsPrivacy,
                  versionLabel: l10n.settingsAppVersionLabel,
                  versionValue: l10n.settingsAppVersionValue,
                  onPrivacyTap: _openPrivacyPolicy,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openPrivacyPolicy() async {
    final uri = Uri.parse(SettingsScreen.privacyPolicyUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _showLanguagePicker(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final selected = await showModalBottomSheet<SupportedLanguage>(
      context: context,
      backgroundColor: BrutalistColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        side: BorderSide(color: BrutalistColors.headerBorder),
      ),
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
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
      SupportedLanguage.ar => l10n.settingsLanguageArabic,
    };
  }
}
