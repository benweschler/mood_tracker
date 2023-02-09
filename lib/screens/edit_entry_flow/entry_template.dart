import 'package:flutter/foundation.dart';
import 'package:parchment/constants.dart';
import 'package:parchment/data/mood_entry.dart';

class EntryTemplate extends ChangeNotifier {
  int _mood;
  Duration _sleep;
  String _description;
  DateTime _timestamp;

  EntryTemplate.fromEntry(MoodEntry? entry)
      : _mood = entry?.mood ?? 5,
        _sleep = entry?.sleep ?? Constants.sleepGoal,
        _description = entry?.description ?? "",
        _timestamp = entry?.timestamp ?? DateTime.now();

  MoodEntry toEntry() => MoodEntry(
        mood: _mood,
        sleep: _sleep,
        description: _description,
        timestamp: _timestamp,
      );

  DateTime get timestamp => _timestamp;

  set timestamp(DateTime value) {
    _timestamp = value;
    notifyListeners();
  }

  String get description => _description;

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  Duration get sleep => _sleep;

  set sleep(Duration value) {
    _sleep = value;
    notifyListeners();
  }

  int get mood => _mood;

  set mood(int value) {
    _mood = value;
    notifyListeners();
  }
}
