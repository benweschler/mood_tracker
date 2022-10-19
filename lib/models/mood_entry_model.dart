import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:mood_tracker/constants.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/utils/date_time_utils.dart';

class MoodEntryModel extends ChangeNotifier {
  final LazyBox<MoodEntry> _entryBox;
  final Map<DateTime, MoodEntry> _entryMap;

  MoodEntryModel._internal({
    required LazyBox<MoodEntry> entryBox,
    required Map<DateTime, MoodEntry> entryMap,
  })  : _entryBox = entryBox,
        _entryMap = entryMap;

  static Future<MoodEntryModel> create() async {
    final LazyBox<MoodEntry> entryBox = Hive.lazyBox(Constants.entryBoxName);
    final Map<DateTime, MoodEntry> entryMap = {};

    for (String key in entryBox.keys) {
      entryMap[DateTime.fromMillisecondsSinceEpoch(int.parse(key)).toDate()] =
          (await entryBox.get(key))!;
    }

    return MoodEntryModel._internal(entryBox: entryBox, entryMap: entryMap);
  }

  Iterable<DateTime> get dates => _entryMap.keys;

  void addEntry(MoodEntry entry) {
    _entryMap[entry.timestamp.toDate()] = entry;
    notifyListeners();
    _entryBox.put(entry.timestamp.toDate().millisecondsSinceEpoch.toString(), entry);
  }

  MoodEntry? entryOn(DateTime day) {
    return _entryMap[day.toDate()];
  }
}
