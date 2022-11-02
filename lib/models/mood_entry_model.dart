import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_tracker/constants.dart';
import 'package:mood_tracker/data/logger.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/utils/date_time_utils.dart';

class MoodEntryModel extends ChangeNotifier {
  final Box<MoodEntry> _entryBox = Hive.box(Constants.entryBoxName);

  Iterable<DateTime> get dates => _entryBox.keys
      .map((unix) => DateTime.fromMillisecondsSinceEpoch(int.parse(unix)));

  Future<void> addEntry(MoodEntry entry) async {
    await _entryBox.put(
      entry.timestamp.toDate().millisecondsSinceEpoch.toString(),
      entry,
    );
    notifyListeners();
  }

  void removeEntry(MoodEntry entry) async {
    final key = entry.timestamp.toDate().millisecondsSinceEpoch.toString();
    if (!_entryBox.containsKey(key)) {
      Logger.add("Timestamp ${entry.timestamp} not found.");
      Logger.add("Current keys: ${_entryBox.keys}");
    }

    await _entryBox.delete(key);
    notifyListeners();
  }

  MoodEntry? entryOn(DateTime day) =>
      _entryBox.get(day.millisecondsSinceEpoch.toString());
}
