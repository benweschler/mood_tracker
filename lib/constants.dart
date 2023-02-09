import 'package:parchment/utils/date_time_utils.dart';

import 'data/mood_entry.dart';
import 'models/mood_entry_model.dart';

abstract class Constants {
  static const int maxMood = 10;
  static const Duration sleepGoal = Duration(hours: 7, minutes: 30);

  static const String entryBoxName = "entries";

  static loadDummyData(MoodEntryModel model, [int offset = 0]) {
    offset *= 4;

    final dummyData = [
      MoodEntry(
        mood: 3,
        sleep: const Duration(hours: 4, minutes: 30),
        description: "Bad day.",
        timestamp: DateTime.now().copyWith(day: DateTime.now().day - 1 - offset),
      ),
      MoodEntry(
        mood: 8,
        sleep: const Duration(hours: 9),
        description: "Good day.",
        timestamp: DateTime.now().copyWith(day: DateTime.now().day - 2 - offset),
      ),
      MoodEntry(
        mood: 1,
        sleep: const Duration(hours: 5),
        description: "Super bad day.",
        timestamp: DateTime.now().copyWith(day: DateTime.now().day - 3 - offset),
      ),
      MoodEntry(
        mood: 10,
        sleep: const Duration(hours: 9),
        description: "Perfect day.",
        timestamp: DateTime.now().copyWith(day: DateTime.now().day - 4 - offset),
      )
    ];

    for(MoodEntry entry in dummyData) {
      model.addEntry(entry);
    }
  }
}

