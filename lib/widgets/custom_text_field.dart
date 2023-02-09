import 'package:flutter/material.dart';
import 'package:parchment/styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool allowMultiline;

  const CustomTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.hintText,
    this.allowMultiline = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyles.body1,
      textInputAction: TextInputAction.done,
      focusNode: focusNode,
      cursorColor: AppColors.contrastColor,
      keyboardType: keyboardType,
      maxLines: allowMultiline ? null : 1,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(Insets.med),
        isDense: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.contrastColor, width: 1),
          borderRadius: Corners.medBorderRadius,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.contrastColor, width: 2),
          borderRadius: Corners.medBorderRadius,
        ),
      ),
    );
  }
}
