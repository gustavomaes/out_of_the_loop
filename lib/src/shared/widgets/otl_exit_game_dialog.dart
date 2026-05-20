import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/theme.dart';

/// Shows the exit-game dialog and runs [onBack] or pops the route when confirmed.
Future<void> confirmExitGameOnBack(
  BuildContext context, {
  VoidCallback? onBack,
}) async {
  final confirmed = await showOtlExitGameDialog(context);
  if (!confirmed || !context.mounted) {
    return;
  }

  if (onBack != null) {
    onBack();
    return;
  }

  context.pop();
}

/// Confirms leaving an in-progress match. Returns `true` when the user chooses
/// to exit and cancel the match.
Future<bool> showOtlExitGameDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final result = await showDialog<bool>(
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
                l10n.questionRoundExitTitle,
                style: DisplayTypography.rubikTitle(
                  color: BrutalistColors.cardText,
                  fontSize: 22,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.questionRoundExitMessage,
                style: DisplayTypography.rubikSettingLabel(
                  color: BrutalistColors.sectionLabel,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              _ExitGameDialogButton(
                label: l10n.questionRoundExitConfirm,
                backgroundColor: BrutalistColors.playerCardPink,
                foregroundColor: Colors.white,
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
              const SizedBox(height: 12),
              _ExitGameDialogButton(
                label: l10n.questionRoundExitStay,
                backgroundColor: BrutalistColors.lime,
                foregroundColor: Colors.black,
                onPressed: () => Navigator.of(dialogContext).pop(false),
              ),
            ],
          ),
        ),
      );
    },
  );

  return result ?? false;
}

class _ExitGameDialogButton extends StatelessWidget {
  const _ExitGameDialogButton({
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
          onTap: onPressed,
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
