import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar({
    required this.name,
    this.seed,
    this.size = 40,
    super.key,
  });

  final String name;
  final String? seed;
  final double size;

  static const _palette = <Color>[
    AppColors.primaryMain,
    AppColors.secondaryMain,
    AppColors.info,
    AppColors.success,
    AppColors.warning,
  ];

  @override
  Widget build(BuildContext context) {
    final initials = _initialsFor(name);
    final color = _palette[_hash(seed ?? name) % _palette.length];

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.backgroundPrimary, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: size * 0.25,
          ),
        ],
      ),
      child: Text(
        initials,
        style: AppTypography.emphasis.copyWith(
          color: _foregroundFor(color),
          fontSize: size * 0.4,
          letterSpacing: 0,
        ),
      ),
    );
  }

  static String _initialsFor(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return '?';
    }
    return parts
        .take(2)
        .map((part) => part.characters.first)
        .join()
        .toUpperCase();
  }

  static int _hash(String value) {
    var hash = 0;
    for (final codeUnit in value.codeUnits) {
      hash = 0x1fffffff & (hash + codeUnit);
      hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
      hash ^= hash >> 6;
    }
    return hash.abs();
  }

  static Color _foregroundFor(Color color) {
    return color == AppColors.primaryMain ||
            color == AppColors.success ||
            color == AppColors.warning
        ? AppColors.backgroundPrimary
        : AppColors.textPrimary;
  }
}
