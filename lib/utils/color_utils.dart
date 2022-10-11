import 'dart:ui';

import 'package:mood_tracker/constants.dart';

Color colorFromMood(int mood) {
  const negativeColor = Color(0xFFe07a5f);
  const positiveColor = Color(0xFF81b29a);

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