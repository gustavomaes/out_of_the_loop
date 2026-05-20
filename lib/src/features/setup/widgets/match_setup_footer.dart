import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../shared/sound/sound_effects_scope.dart';
import '../../../theme/theme.dart';

class MatchSetupFooter extends StatelessWidget {
  const MatchSetupFooter({
    required this.label,
    required this.enabled,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  static const _height = 80.0;
  static const _shadowOffset = 8.0;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: BrutalistColors.footerScrim),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomPadding),
            child: Opacity(
              opacity: enabled ? 1 : 0.45,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: _shadowOffset,
                  bottom: _shadowOffset,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Transform.translate(
                        offset: const Offset(_shadowOffset, _shadowOffset),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height,
                      width: double.infinity,
                      child: Material(
                        color: BrutalistColors.lime,
                        child: InkWell(
                          onTap: otlTap(context, onPressed),
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 4,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  label,
                                  style: DisplayTypography.rubikPlayerSetupCta(
                                    color: BrutalistColors.homePrimaryButtonText,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.arrow_forward,
                                  color: BrutalistColors.homePrimaryButtonText,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
