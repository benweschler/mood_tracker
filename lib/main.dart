import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mood_tracker/theme.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'screens/home.dart';
import 'models/mood_entry_model.dart';

void main() {
  final moodModel = MoodEntryModel();
  for (var entry in Constants.dummyData) {
    moodModel.addEntry(entry);
  }
  runApp(ChangeNotifierProvider<MoodEntryModel>.value(
    value: moodModel,
    child: const MoodTracker(),
  ));
}

class MoodTracker extends StatelessWidget {
  const MoodTracker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Home(),
      ),
    );
  }
}
