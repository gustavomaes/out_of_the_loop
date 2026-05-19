import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

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

  static const _musicIcon = Color(0xFFFF3DF2);
  static const _sfxIcon = Color(0xFFFFE170);

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
            _SettingsSection(
              label: l10n.settingsSectionLanguage,
              child: _LanguageSelector(
                label: _languageLabel(l10n, _language),
                onTap: () => _showLanguagePicker(context, l10n),
              ),
            ),
            const SizedBox(height: 24),
            _SettingsSection(
              label: l10n.settingsSectionAudio,
              child: Column(
                children: [
                  _AudioToggleRow(
                    icon: Icons.music_note,
                    iconColor: SettingsScreen._musicIcon,
                    label: l10n.settingsMusic,
                    value: _musicEnabled,
                    onChanged: (value) {
                      setState(() => _musicEnabled = value);
                      widget.onMusicEnabledChanged?.call(value);
                    },
                  ),
                  const SizedBox(height: 12),
                  _AudioToggleRow(
                    icon: Icons.volume_up,
                    iconColor: SettingsScreen._sfxIcon,
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
            _SettingsSection(
              label: l10n.settingsSectionTimer,
              child: _TimerSettingsCard(
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
            _SettingsSection(
              label: l10n.settingsSectionAbout,
              child: _AboutCard(
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

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: DisplayTypography.spaceGroteskSectionLabel(
            color: BrutalistColors.sectionLabel,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 6,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 64,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: DisplayTypography.rubikSettingLabel(
                color: BrutalistColors.cardText,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: BrutalistColors.cardText,
            size: 28,
          ),
        ],
      ),
    );
  }
}

class _AudioToggleRow extends StatelessWidget {
  const _AudioToggleRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 6,
      padding: const EdgeInsets.all(24),
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              label,
              style: DisplayTypography.rubikSettingLabel(
                color: BrutalistColors.cardText,
              ),
            ),
          ),
          _BrutalistToggle(value: value),
        ],
      ),
    );
  }
}

class _TimerSettingsCard extends StatelessWidget {
  const _TimerSettingsCard({
    required this.enabled,
    required this.durationSeconds,
    required this.useTimerLabel,
    required this.durationLabel,
    required this.onEnabledChanged,
    required this.onDurationChanged,
  });

  final bool enabled;
  final int durationSeconds;
  final String useTimerLabel;
  final String durationLabel;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<int> onDurationChanged;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 6,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => onEnabledChanged(!enabled),
            child: Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  color: BrutalistColors.lime,
                  size: 22,
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    useTimerLabel,
                    style: DisplayTypography.rubikSettingLabel(
                      color: BrutalistColors.cardText,
                    ),
                  ),
                ),
                _BrutalistToggle(value: enabled),
              ],
            ),
          ),
          if (enabled) ...[
            const SizedBox(height: 16),
            Text(
              durationLabel,
              style: DisplayTypography.plusJakartaBody(
                color: BrutalistColors.sectionLabel,
                fontSize: 16,
              ),
            ),
            SliderTheme(
              data: const SliderThemeData(
                activeTrackColor: BrutalistColors.lime,
                inactiveTrackColor: BrutalistColors.toggleOff,
                thumbColor: BrutalistColors.lime,
                overlayColor: Color(0x33B7F700),
              ),
              child: Slider(
                value: durationSeconds.toDouble(),
                min: 10,
                max: 60,
                divisions: 5,
                label: '${durationSeconds}s',
                onChanged: (value) => onDurationChanged(value.round()),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.termsLabel,
    required this.privacyLabel,
    required this.versionLabel,
    required this.versionValue,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  final String termsLabel;
  final String privacyLabel;
  final String versionLabel;
  final String versionValue;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 6,
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          _AboutRow(
            label: termsLabel,
            onTap: onTermsTap,
            showChevron: true,
          ),
          const _AboutDivider(),
          _AboutRow(
            label: privacyLabel,
            onTap: onPrivacyTap,
            showChevron: true,
          ),
          const _AboutDivider(),
          _AboutRow(
            label: versionLabel,
            trailing: versionValue,
            showChevron: false,
          ),
        ],
      ),
    );
  }
}

class _AboutDivider extends StatelessWidget {
  const _AboutDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 4,
      thickness: 4,
      color: Colors.black,
    );
  }
}

class _AboutRow extends StatelessWidget {
  const _AboutRow({
    required this.label,
    this.trailing,
    this.onTap,
    this.showChevron = false,
  });

  final String label;
  final String? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: DisplayTypography.plusJakartaBody(
                color: BrutalistColors.cardText,
              ),
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: DisplayTypography.spaceGroteskMeta(
                color: BrutalistColors.versionGreen,
              ),
            )
          else if (showChevron)
            const Icon(
              Icons.chevron_right,
              color: BrutalistColors.cardText,
              size: 20,
            ),
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return InkWell(onTap: onTap, child: content);
  }
}

class _BrutalistToggle extends StatelessWidget {
  const _BrutalistToggle({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 64,
          height: 32,
          padding: EdgeInsets.fromLTRB(value ? 38 : 6, 6, value ? 10 : 42, 6),
          decoration: BoxDecoration(
            color: value ? BrutalistColors.lime : BrutalistColors.toggleOff,
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: Colors.black, width: 2),
          ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}

