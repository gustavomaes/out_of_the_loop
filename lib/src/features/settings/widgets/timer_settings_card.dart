import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

class TimerSettingsCard extends StatelessWidget {
  const TimerSettingsCard({
    required this.enabled,
    required this.durationSeconds,
    required this.useTimerLabel,
    required this.durationLabel,
    required this.onEnabledChanged,
    required this.onDurationChanged,
    super.key,
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
                OtlBrutalistToggle(value: enabled),
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
                overlayColor: BrutalistColors.sliderOverlayLime,
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
