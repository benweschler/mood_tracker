import 'package:flutter/foundation.dart';
import 'package:mood_tracker/mood_entry.dart';
import 'package:mood_tracker/utils.dart';

class MoodEntryModel extends ChangeNotifier {
  final Map<DateTime, MoodEntry> _entryMap = {};

  Iterable<DateTime> get dates => _entryMap.keys;

  void addEntry(MoodEntry entry) {
    _entryMap[entry.timestamp.toDate()] = entry;
    notifyListeners();
  }

  MoodEntry? entryOn(DateTime day) {
    return _entryMap[day];
  }
}
