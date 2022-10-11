import 'package:mood_tracker/constants.dart';
import 'package:mood_tracker/data/mood_entry.dart';

class EntryTemplate {
  int mood;
  Duration sleep;
  String description;
  DateTime timestamp;

  EntryTemplate.fromEntry(MoodEntry? entry)
      : mood = entry?.mood ?? 5,
        sleep = entry?.sleep ?? Constants.sleepGoal,
        description = entry?.description ?? "",
        timestamp = entry?.timestamp ?? DateTime.now();

  MoodEntry toEntry() => MoodEntry(
        mood: mood,
        sleep: sleep,
        description: description,
        timestamp: timestamp,
      );
}
