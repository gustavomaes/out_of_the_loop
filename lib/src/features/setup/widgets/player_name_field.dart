import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class PlayerNameField extends StatelessWidget {
  const PlayerNameField({
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onSubmitted;

  static const _height = 64.0;
  static const _shadowOffset = 4.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _shadowOffset, bottom: _shadowOffset),
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
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.done,
              style: DisplayTypography.plusJakartaBody(
                color: BrutalistColors.cardText,
              ),
              cursorColor: BrutalistColors.lime,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: DisplayTypography.plusJakartaBody(
                  color: BrutalistColors.inputHint,
                ),
                filled: true,
                fillColor: BrutalistColors.cardBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 4),
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 4),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
