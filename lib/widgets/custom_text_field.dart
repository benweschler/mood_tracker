import 'package:flutter/material.dart';
import 'package:mood_tracker/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? hintText;

  const CustomTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      cursorColor: AppColors.contrastColor,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(Insets.sm),
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
