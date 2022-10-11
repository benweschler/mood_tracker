import 'dart:ui';

import 'package:mood_tracker/constants.dart';

Color colorFromMood(int mood) {
  const negativeColor = Color(0xFFE07A5F);
  const positiveColor = Color(0xFF81B29A);

  final t = mood / Constants.maxMood;

  if (t < 0.5) {
    return Color.lerp(negativeColor, negativeColor.withOpacity(0), t * 2)!;
  } else if (t > 0.5) {
    return Color.lerp(
        positiveColor.withOpacity(0), positiveColor, (t - 0.5) * 2)!;
  } else {
    return const Color(0x00000000);
  }
}