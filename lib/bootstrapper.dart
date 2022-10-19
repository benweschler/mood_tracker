import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';
import 'data/duration_adapter.dart';
import 'data/mood_entry.dart';

class Bootstrapper {
  static Future<void> bootstrap() async {
    await _initHive();
  }

  static Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Duration>(DurationAdapter());
    Hive.registerAdapter<MoodEntry>(MoodEntryAdapter());
    await Hive.openLazyBox<MoodEntry>(Constants.entryBoxName);
  }
}
