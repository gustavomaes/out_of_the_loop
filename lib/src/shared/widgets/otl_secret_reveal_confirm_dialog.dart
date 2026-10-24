import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import 'otl_neon_action.dart';
import '../../theme/theme.dart';

/// Confirms the active player is holding the phone before revealing their word.
Future<bool> showSecretRevealConfirmDialog(
  BuildContext context, {
  required String playerName,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: BrutalistColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: BrutalistColors.headerBorder),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.secretRevealConfirmTitle(playerName),
                  style: DisplayTypography.rubikTitle(
                    color: BrutalistColors.cardText,
                    fontSize: 22,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.secretRevealConfirmMessage,
                  style: DisplayTypography.rubikSettingLabel(
                    color: BrutalistColors.sectionLabel,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                _SecretRevealConfirmButton(
                  label: l10n.secretRevealConfirmYes,
                  backgroundColor: BrutalistColors.lime,
                  foregroundColor: Colors.black,
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                ),
                const SizedBox(height: 12),
                _SecretRevealConfirmButton(
                  label: l10n.secretRevealConfirmNo,
                  backgroundColor: BrutalistColors.playerCardPink,
                  foregroundColor: Colors.white,
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  return result ?? false;
}

class _SecretRevealConfirmButton extends StatelessWidget {
  const _SecretRevealConfirmButton({
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
  Widget build(BuildContext context) => OtlNeonAction(
    label: label,
    onPressed: onPressed,
    primary: backgroundColor == BrutalistColors.lime,
  );
}
