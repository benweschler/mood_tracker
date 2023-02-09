import 'package:flutter/material.dart';

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

abstract class AppColors {
  static const Color contrastColor = Color(0xFF3D405B);
  static const Color mutedColor = Color(0xBF3D405B);
}

abstract class Insets {
  static const double offset = 12.5;
  static const double xs = 5;
  static const double sm = 10;
  static const double med = 15;
  static const double lg = 20;
}

abstract class TextStyles {
  static const Color _textColor = AppColors.contrastColor;

  static const heading = TextStyle(fontSize: 28, color: _textColor, fontWeight: FontWeight.bold);
  static const title = TextStyle(fontSize: 18, color: _textColor, fontWeight: FontWeight.w600);
  static const body1 = TextStyle(fontSize: 16, color: _textColor);
  static const body2 = TextStyle(fontSize: 14, color: _textColor);
  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.normal);
}

abstract class Durations {
  static const Duration short = Duration(milliseconds: 150);
  static const Duration med = Duration(milliseconds: 300);
}

abstract class Corners {
  static const double med = 10;
  static const Radius medRadius = Radius.circular(med);
  static const BorderRadius medBorderRadius = BorderRadius.all(medRadius);
}
