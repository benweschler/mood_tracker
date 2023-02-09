import 'package:flutter/material.dart';
import 'package:parchment/data/mood_entry.dart';
import 'package:parchment/models/mood_entry_model.dart';
import 'package:provider/provider.dart';
import 'package:parchment/theme.dart';

import 'entry_card.dart';
import 'mood_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late final ValueNotifier<DateTime?> calendarNotifier;

  @override
  void initState() {
    final dates = context.read<MoodEntryModel>().dates;
    calendarNotifier = ValueNotifier(
        dates.isEmpty ? null : dates.reduce((a, b) => a.isAfter(b) ? a : b));
    super.initState();
  }

  @override
  void dispose() {
    calendarNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableProvider<DateTime?>.value(
      value: calendarNotifier,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.offset),
        child: ListView(
          children: [
            MoodCalendar(onDateTapped: (day) => calendarNotifier.value = day),
            const SizedBox(height: Insets.lg),
            ValueListenableBuilder(
              valueListenable: calendarNotifier,
              builder: (context, selectedDay, _) {
                final entry = context.select<MoodEntryModel, MoodEntry?>(
                      (model) =>
                  selectedDay != null ? model.entryOn(selectedDay) : null,
                );
                return entry != null ? EntryDetailsCard(entry) : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}