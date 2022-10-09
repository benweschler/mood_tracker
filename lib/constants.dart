import 'package:mood_tracker/utils.dart';

import 'mood_entry.dart';

class Constants {
  static const double maxMood = 10;

  static final dummyData = [
    MoodEntry(
      mood: 5,
      sleep: 7,
      description: "meh day.",
      timestamp: DateTime.now(),
    ),
    MoodEntry(
      mood: 3,
      sleep: 4.5,
      description: "Bad day.",
      timestamp: DateTime.now().copyWith(day: DateTime.now().day - 1),
    ),
    MoodEntry(
      mood: 8,
      sleep: 9,
      description: "Good day.",
      timestamp: DateTime.now().copyWith(day: DateTime.now().day - 2),
    ),
    MoodEntry(
      mood: 1,
      sleep: 5,
      description: "Hope this doesn't happen again.",
      timestamp: DateTime.now().copyWith(day: DateTime.now().day - 3),
    ),
    MoodEntry(
      mood: 9.5,
      sleep: 9,
      description: "You're probably manic.",
      timestamp: DateTime.now().copyWith(day: DateTime.now().day - 4),
    )
  ];
}

