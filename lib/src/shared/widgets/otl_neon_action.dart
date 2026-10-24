import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../sound/sound_effects_scope.dart';

/// One consistent, wrapping action for gameplay, forms and dialogs.
class OtlNeonAction extends StatelessWidget {
  const OtlNeonAction({
    required this.label,
    required this.onPressed,
    this.primary = true,
    this.icon,
    super.key,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool primary;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final style = TextButton.styleFrom(
      foregroundColor: primary
          ? BrutalistColors.limeText
          : BrutalistColors.cardText,
      backgroundColor: primary
          ? BrutalistColors.lime
          : BrutalistColors.cardBackground,
      disabledForegroundColor: AppColors.textTertiary,
      disabledBackgroundColor: BrutalistColors.cardBackground,
      minimumSize: const Size(double.infinity, 56),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: primary
            ? BorderSide.none
            : const BorderSide(color: BrutalistColors.headerBorder),
      ),
      textStyle: DisplayTypography.rubikHomeButton(
        color: BrutalistColors.limeText,
        fontSize: 16,
      ),
    );
    return TextButton(
      style: style,
      onPressed: otlTap(context, onPressed),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: Text(label, textAlign: TextAlign.center)),
          if (icon != null) ...[
            const SizedBox(width: 10),
            Icon(icon, size: 20),
          ],
        ],
      ),
    );
  }
}

class OtlNeonFooter extends StatelessWidget {
  const OtlNeonFooter({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => ColoredBox(
    color: BrutalistColors.screenBackground,
    child: SafeArea(
      top: false,
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: child,
          ),
        ),
      ),
    ),
  );
}

/// Keeps discovery and setup content comfortable on tablets without changing
/// the viewport height available to scrollable children.
class OtlContentWidth extends StatelessWidget {
  const OtlContentWidth({required this.child, this.maxWidth = 520, super.key});
  final Widget child;
  final double maxWidth;
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}
