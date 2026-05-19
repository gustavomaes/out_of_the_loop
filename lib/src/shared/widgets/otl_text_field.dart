import 'package:flutter/material.dart';

import '../../theme/app_tokens.dart';

class OtlTextField extends StatelessWidget {
  const OtlTextField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.textInputAction,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      textInputAction: textInputAction,
      style: AppTypography.body.copyWith(color: AppColors.textPrimary),
      cursorColor: AppColors.primaryMain,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
        floatingLabelStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.primaryMain,
          fontWeight: FontWeight.w700,
        ),
        hintStyle: AppTypography.body.copyWith(color: AppColors.textTertiary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 12,
        ),
      ),
    );
  }
}
