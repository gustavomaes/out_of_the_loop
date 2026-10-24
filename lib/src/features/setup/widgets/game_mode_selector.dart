import 'package:flutter/material.dart';
import '../../../domain/models/models.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../theme/theme.dart';

class GameModeSelector extends StatelessWidget {
  const GameModeSelector({
    required this.value,
    required this.onChanged,
    super.key,
  });
  final GameMode value;
  final ValueChanged<GameMode> onChanged;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.gameModeLabel,
          style: DisplayTypography.rubikSettingLabel(
            color: BrutalistColors.cardText,
          ),
        ),
        const SizedBox(height: 12),
        for (final mode in GameMode.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Semantics(
              selected: value == mode,
              child: Material(
                color: BrutalistColors.cardBackground,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: value == mode
                        ? BrutalistColors.lime
                        : BrutalistColors.headerBorder,
                    width: value == mode ? 2 : 1,
                  ),
                ),
                child: InkWell(
                  key: ValueKey('mode-${mode.name}'),
                  onTap: () => onChanged(mode),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Icon(
                          mode == GameMode.guided
                              ? Icons.chat_bubble_outline
                              : Icons.auto_awesome_outlined,
                          color: BrutalistColors.lime,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mode == GameMode.guided
                                    ? l10n.guidedMode
                                    : l10n.freeMode,
                                style: DisplayTypography.rubikPlayerCardName(
                                  color: BrutalistColors.cardText,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                mode == GameMode.guided
                                    ? l10n.guidedModeDescription
                                    : l10n.freeModeDescription,
                                style: DisplayTypography.plusJakartaBody(
                                  color: BrutalistColors.sectionLabel,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          value == mode
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: value == mode
                              ? BrutalistColors.lime
                              : BrutalistColors.sectionLabel,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
