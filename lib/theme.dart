import 'package:flutter/material.dart';
import 'package:parchment/styles.dart';

abstract class AppTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF4F1DE),
    dividerTheme: const DividerThemeData(
      space: 0,
      color: AppColors.contrastColor,
    ),
  );
}
