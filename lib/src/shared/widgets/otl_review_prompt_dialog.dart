import 'package:flutter/material.dart';

import '../../domain/services/app_review_prompt.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../theme/theme.dart';
import 'otl_neon_action.dart';

/// Asks whether the table wants to rate the app. Returns null when the route
/// is popped before a choice, which does not count as a decline.
Future<ReviewPromptChoice?> showOtlReviewPromptDialog(
  BuildContext context,
) async {
  final l10n = AppLocalizations.of(context)!;
  return showDialog<ReviewPromptChoice>(
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
                  l10n.reviewPromptTitle,
                  style: DisplayTypography.rubikTitle(
                    color: BrutalistColors.cardText,
                    fontSize: 22,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.reviewPromptMessage,
                  style: DisplayTypography.rubikSettingLabel(
                    color: BrutalistColors.sectionLabel,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                _ReviewPromptButton(
                  label: l10n.reviewPromptRate,
                  backgroundColor: BrutalistColors.lime,
                  foregroundColor: Colors.black,
                  onPressed: () =>
                      Navigator.of(dialogContext).pop(ReviewPromptChoice.rate),
                ),
                const SizedBox(height: 12),
                _ReviewPromptButton(
                  label: l10n.reviewPromptLater,
                  backgroundColor: BrutalistColors.cardBackground,
                  foregroundColor: BrutalistColors.cardText,
                  onPressed: () =>
                      Navigator.of(dialogContext).pop(ReviewPromptChoice.later),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _ReviewPromptButton extends StatelessWidget {
  const _ReviewPromptButton({
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
