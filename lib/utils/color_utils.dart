import 'dart:ui';

import 'package:parchment/constants.dart';

Color colorFromMood(int mood) {
  const negativeColor = Color(0xFFf19f8a);
  const positiveColor = Color(0xFFadd4c1);

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

