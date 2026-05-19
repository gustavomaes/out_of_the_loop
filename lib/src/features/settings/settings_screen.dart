import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    this.initialLanguage = SupportedLanguage.ptBr,
    this.initialTimerSettings = const TimerSettings(),
    this.onLanguageChanged,
    this.onTimerChanged,
    super.key,
  });

  final SupportedLanguage initialLanguage;
  final TimerSettings initialTimerSettings;
  final ValueChanged<SupportedLanguage>? onLanguageChanged;
  final ValueChanged<TimerSettings>? onTimerChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SupportedLanguage _language = widget.initialLanguage;
  late TimerSettings _timerSettings = widget.initialTimerSettings;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      routeName: AppRoutes.settings,
      title: 'Settings',
      child: ListView(
        children: [
          const Text('Configuracoes', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.lg),
          OtlCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('IDIOMA', style: AppTypography.emphasis),
                const SizedBox(height: AppSpacing.sm),
                for (final language in SupportedLanguage.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: InkWell(
                      borderRadius: AppRadius.borderMd,
                      onTap: () {
                        setState(() => _language = language);
                        widget.onLanguageChanged?.call(language);
                      },
                      child: OtlCard(
                        selected: language == _language,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _labelFor(language),
                                style: AppTypography.body.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (language == _language)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primaryMain,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          OtlCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TIMER', style: AppTypography.emphasis),
                const SizedBox(height: AppSpacing.sm),
                SwitchListTile(
                  value: _timerSettings.enabled,
                  activeThumbColor: AppColors.primaryMain,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Use timer',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    '${_timerSettings.durationSeconds} seconds per turn',
                    style: AppTypography.bodySmall,
                  ),
                  onChanged: (enabled) => _updateTimer(
                    TimerSettings(
                      enabled: enabled,
                      durationSeconds: _timerSettings.durationSeconds,
                    ),
                  ),
                ),
                Slider(
                  value: _timerSettings.durationSeconds.toDouble(),
                  min: 10,
                  max: 60,
                  divisions: 5,
                  activeColor: AppColors.primaryMain,
                  inactiveColor: AppColors.backgroundTertiary,
                  label: '${_timerSettings.durationSeconds}s',
                  onChanged: (value) => _updateTimer(
                    TimerSettings(
                      enabled: _timerSettings.enabled,
                      durationSeconds: value.round(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Profile, login, Pro purchase, audio, and light theme are out of scope for the MVP.',
            style: AppTypography.label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _updateTimer(TimerSettings settings) {
    setState(() => _timerSettings = settings);
    widget.onTimerChanged?.call(settings);
  }

  String _labelFor(SupportedLanguage language) {
    return switch (language) {
      SupportedLanguage.ptBr => 'Portuguese (Brazil)',
      SupportedLanguage.en => 'English',
      SupportedLanguage.es => 'Spanish',
      SupportedLanguage.hi => 'Hindi',
    };
  }
}
