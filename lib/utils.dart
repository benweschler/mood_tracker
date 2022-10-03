import 'dart:ui';

import 'package:flutter/material.dart';

import 'constants.dart';

extension DateUtils on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime toDate() {
    return DateTime.utc(year, month, day);
  }
}

Color colorFromMood(double mood) {
  const negativeColor = Color(0xFFe07a5f);
  const positiveColor =  Color(0xFF81b29a);

  final t = mood / Constants.maxMood;

  if(t < 0.5) {
    return Color.lerp(negativeColor, negativeColor.withOpacity(0), t * 2)!;
  } else if(t > 0.5) {
    return Color.lerp(positiveColor.withOpacity(0), positiveColor, (t - 0.5) * 2)!;
  } else {
    return const Color(0x00000000);
  }
}