import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/screens/mood_calendar.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/color_utils.dart';
import 'package:mood_tracker/utils/date_time_utils.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

import 'edit_entry_screen/edit_entry_wrapper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final calendarNotifier = ValueNotifier<DateTime>(DateTime.now().toDate());

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
              builder: (context, selectedDay, _) => EntryDetails(
                context.select<MoodEntryModel, MoodEntry?>(
                  (model) => model.entryOn(selectedDay),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EntryDetails extends StatelessWidget {
  final MoodEntry? entry;

  const EntryDetails(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (entry == null) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat.MMMMEEEEd().add_jm().format(entry!.timestamp),
          style: TextStyles.body,
        ),
        const SizedBox(height: Insets.sm),
        Container(
          padding: const EdgeInsets.all(Insets.med),
          decoration: BoxDecoration(
            color: colorFromMood(entry!.mood),
            border: Border.all(color: AppColors.contrastColor, width: 2),
            borderRadius: Corners.medBorderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Insets.med),
              Column(
                children: [
                  Row(
                    children: const [
                      Text("MOOD", style: TextStyles.body),
                      Text("SLEEP", style: TextStyles.body),
                    ].map((e) => Expanded(child: Center(child: e))).toList(),
                  ),
                  Row(
                    children: [
                      Text("${entry!.mood}", style: TextStyles.heading),
                      Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: "${entry!.sleep.inHours}",
                            style: TextStyles.heading,
                          ),
                          TextSpan(
                            text: "h ",
                            style: TextStyles.title
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: "${entry!.sleep.inMinutes.remainder(60)}",
                            style: TextStyles.heading,
                          ),
                          TextSpan(
                            text: "m",
                            style: TextStyles.title
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                        ],
                      )),
                    ].map((e) => Expanded(child: Center(child: e))).toList(),
                  ),
                ],
              ),
              const SizedBox(height: Insets.lg),
              Text(
                entry!.description,
                style: TextStyles.title.copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
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
