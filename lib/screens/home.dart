import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/screens/mood_calendar.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/color_utils.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

import 'edit_entry_flow/edit_entry_wrapper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final calendarNotifier = ValueNotifier<DateTime>(
    context.read<MoodEntryModel>().dates.reduce(
          (a, b) => a.isAfter(b) ? a : b,
        ),
  );

  @override
  void dispose() {
    calendarNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableProvider<DateTime?>.value(
      value: calendarNotifier,
      child: CustomScaffold(
        bottomActionButton: const _EntryActionButton(),
        child: ListView(
          children: [
            MoodCalendar(
              onDateTapped: (day) => calendarNotifier.value = day,
            ),
            const SizedBox(height: Insets.lg),
            ValueListenableBuilder(
              valueListenable: calendarNotifier,
              builder: (context, selectedDay, _) {
                final entry = context.select<MoodEntryModel, MoodEntry?>(
                    (model) => model.entryOn(selectedDay));
                return entry != null ? _EntryDetailsCard(entry) : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EntryDetailsCard extends StatelessWidget {
  final MoodEntry entry;

  const _EntryDetailsCard(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.med),
      decoration: BoxDecoration(
        color: colorFromMood(entry.mood),
        border: Border.all(color: AppColors.contrastColor, width: 2),
        borderRadius: Corners.medBorderRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${entry.mood}", style: TextStyles.heading),
          const SizedBox(width: Insets.med),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.MMMMEEEEd().format(entry.timestamp).toUpperCase(),
                style: TextStyles.body
                    .copyWith(fontSize: 16, color: TextStyles.captionColor),
              ),
              const SizedBox(height: Insets.lg),
              Text(
                entry.description,
                style: TextStyles.title.copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EntryActionButton extends StatelessWidget {
  const _EntryActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      color: AppColors.contrastColor,
      onTap: () => context.push(
        EditEntryWrapper(
          entry:
              context.read<MoodEntryModel>().entryOn(context.read<DateTime>()),
        ),
        fullscreenDialog: true,
      ),
      label: "Add Entry",
      icon: Icons.add_rounded,
    );
  }
}
