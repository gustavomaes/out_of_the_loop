import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../sound/sound_effects_scope.dart';
import '../../theme/theme.dart';

enum NewMatchDialogChoice { keepCategory, changeCategory }

Future<NewMatchDialogChoice?> showNewMatchDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  return showDialog<NewMatchDialogChoice>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: BrutalistColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Colors.black, width: 4),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.newMatchDialogTitle,
                style: DisplayTypography.rubikTitle(
                  color: BrutalistColors.cardText,
                  fontSize: 22,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.newMatchDialogMessage,
                style: DisplayTypography.rubikSettingLabel(
                  color: BrutalistColors.sectionLabel,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              _NewMatchDialogButton(
                label: l10n.newMatchKeepCategory,
                backgroundColor: BrutalistColors.lime,
                foregroundColor: Colors.black,
                onPressed: () => Navigator.of(
                  dialogContext,
                ).pop(NewMatchDialogChoice.keepCategory),
              ),
              const SizedBox(height: 12),
              _NewMatchDialogButton(
                label: l10n.newMatchChangeCategory,
                backgroundColor: BrutalistColors.playerCardPink,
                foregroundColor: Colors.white,
                onPressed: () => Navigator.of(
                  dialogContext,
                ).pop(NewMatchDialogChoice.changeCategory),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _NewMatchDialogButton extends StatelessWidget {
  const _NewMatchDialogButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: otlTap(context, onPressed),
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 4),
            ),
            child: Center(
              child: Text(
                label,
                style: DisplayTypography.rubikHomeButton(color: foregroundColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
