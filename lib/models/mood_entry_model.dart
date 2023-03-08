import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parchment/constants.dart';
import 'package:parchment/data/entry_tag.dart';
import 'package:parchment/data/logger.dart';
import 'package:parchment/data/mood_entry.dart';
import 'package:parchment/utils/date_time_utils.dart';

class MoodEntryModel extends ChangeNotifier {
  final Box<MoodEntry> _entryBox = Hive.box(Constants.entryBoxName);
  final Set<EntryTag> _entryTags = {
    const EntryTag(
      label: "You",
      icon: Icons.person_rounded,
    ),
    const EntryTag(
      label: "Got This 😊",
      icon: Icons.bed_rounded,
    ),
  };

  Iterable<EntryTag> get tags => _entryTags;

  Iterable<DateTime> get dates => _entryBox.keys.map(
        (unix) => DateTime.fromMillisecondsSinceEpoch(
          int.parse(unix),
          isUtc: true,
        ),
      );

  Future<void> addEntry(MoodEntry entry) async {
    await _entryBox.put(
      entry.timestamp.toDate().millisecondsSinceEpoch.toString(),
      entry,
    );
    notifyListeners();

    Logger.add("Added entry on ${entry.timestamp}");
  }

  void removeEntry(MoodEntry entry) async {
    final key = entry.timestamp.toDate().millisecondsSinceEpoch.toString();
    if (!_entryBox.containsKey(key)) {
      Logger.add("Timestamp ${entry.timestamp} not found.");
      Logger.add("Current keys: ${_entryBox.keys}");
    }

    await _entryBox.delete(key);
    notifyListeners();

    Logger.add("Removed entry on ${entry.timestamp}");
  }

  MoodEntry? entryOn(DateTime day) =>
      _entryBox.get(day.millisecondsSinceEpoch.toString());
}
