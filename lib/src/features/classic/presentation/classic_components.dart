import '../application/classic_experience.dart';
import 'package:flutter/material.dart';

abstract final class CoralTokens {
  static const canvas = Color(0xFFFFF9F3);
  static const surface = Color(0xFFFFFDFB);
  static const ink = Color(0xFF38221D);
  static const muted = Color(0xFF806961);
  static const primary = Color(0xFFC84232);
  static const border = Color(0xFFEADBD2);
  static const peach = Color(0xFFFAE8DD);
  static const gold = Color(0xFFF7C862);
  static const success = Color(0xFF346C53);
  static const focus = Color(0xFF426FBD);
  static const spacing = [4.0, 8.0, 12.0, 16.0, 24.0, 32.0];
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: canvas,
    fontFamily: 'PlusJakartaSans',
    fontFamilyFallback: const ['Arial', 'Apple Color Emoji'],
    colorScheme: ColorScheme.fromSeed(seedColor: primary).copyWith(
      primary: primary,
      surface: surface,
      onSurface: ink,
      error: primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(54, 54),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      ),
    ),
  );
}

class ClassicButton extends StatelessWidget {
  const ClassicButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.error,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final String? error;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: loading || onPressed == null
            ? null
            : () {
                ClassicExperienceScope.of(context)?.tap();
                onPressed!();
              },
        child: loading
            ? Semantics(
                label: label,
                liveRegion: true,
                child: const SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : Text(label),
      ),
      if (error != null)
        Semantics(
          liveRegion: true,
          child: Text(
            error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
    ],
  );
}

class ClassicCard extends StatelessWidget {
  const ClassicCard({super.key, required this.child, this.error});
  final Widget child;
  final String? error;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: CoralTokens.surface,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: error == null ? CoralTokens.border : CoralTokens.primary,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        child,
        if (error != null) Semantics(liveRegion: true, child: Text(error!)),
      ],
    ),
  );
}

class ClassicSwitch extends StatelessWidget {
  const ClassicSwitch({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
  });
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;
  @override
  Widget build(BuildContext context) => SwitchListTile.adaptive(
    contentPadding: EdgeInsets.zero,
    title: Text(label),
    value: value,
    onChanged: onChanged,
  );
}

Future<void> showClassicSheet(
  BuildContext context, {
  required String title,
  required Widget child,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  showDragHandle: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(27)),
  ),
  builder: (context) => SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(
      24,
      8,
      24,
      24 + MediaQuery.viewInsetsOf(context).bottom,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            IconButton(
              tooltip: MaterialLocalizations.of(context).closeButtonLabel,
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const SizedBox(height: 24),
        child,
      ],
    ),
  ),
);
