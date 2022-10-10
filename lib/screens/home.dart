import 'package:flutter/material.dart';
import 'package:mood_tracker/screens/mood_calendar.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

import 'edit_entry_screen/edit_entry_wrapper.dart';

class Home extends StatelessWidget {
  final calendarNotifier = ValueNotifier<DateTime?>(null);

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
    );
  }
}

class _AddEntryButton extends StatelessWidget {
  const _AddEntryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      color: AppColors.contrastColor,
      onTap: () => context.push(
        const EditEntryWrapper(),
        fullscreenDialog: true,
      ),
      label: "Add Entry",
      icon: Icons.add_rounded,
    );
  }
}
