import 'package:flutter/material.dart';
import 'package:mood_tracker/screens/mood_calendar.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:provider/provider.dart';

import '../mood_entry_model.dart';
import 'entry_details_screen/entry_details_screen.dart';

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
                child: _AddEntryButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddEntryButton extends StatelessWidget {
  const _AddEntryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      color: AppColors.contrastColor,
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => EntryDetailsScreen(
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
