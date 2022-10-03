import 'package:flutter/material.dart';
import 'package:mood_tracker/screens/edit_entry_screen.dart';
import 'package:mood_tracker/mood_entry.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils.dart';
import 'package:provider/provider.dart';

import 'widgets/action_button.dart';
import 'screens/mood_calendar.dart';
import 'mood_entry_model.dart';

final dummyData = [
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

void main() {
  final moodModel = MoodEntryModel();
  for (var entry in dummyData) {
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
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final calendarNotifier = ValueNotifier<DateTime?>(null);

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: Insets.offset),
        child: ValueListenableProvider<DateTime?>.value(
          value: calendarNotifier,
          child: Stack(
            children: [
              ListView(
                children: [
                  MoodCalendar(
                    onDateTapped: (day) => calendarNotifier.value =
                        calendarNotifier.value != day ? day : null,
                  ),
                ],
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: Insets.offset,
                child: AddEntryButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddEntryButton extends StatelessWidget {
  const AddEntryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      color: AppColors.contrastColor,
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => EditEntryScreen(
          createEntry: (entry) =>
              context.read<MoodEntryModel>().addEntry(entry),
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Add Entry",
            style: TextStyles.title.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const SizedBox(width: Insets.med),
          Icon(
            Icons.add_rounded,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ],
      ),
    );
  }
}
