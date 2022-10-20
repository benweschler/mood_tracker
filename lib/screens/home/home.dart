import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/screens/edit_entry_flow/edit_entry_wrapper.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/date_time_utils.dart';
import 'package:mood_tracker/utils/emoji_text_span.dart';
import 'package:mood_tracker/utils/iterable_utils.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/buttons/action_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

import 'components/entry_card.dart';
import 'components/mood_calendar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomActionButton: const _EntryActionButton(),
      addBorderInsets: false,
      child: PageView(
        controller: _controller,
        children: const [
          TimelineView(),
          CalendarView(),
        ],
      ),
    );
  }
}

class TimelineView extends StatelessWidget {
  const TimelineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MoodEntryModel>();
    final List<DateTime> dates = model.dates.toList()..sort();

    if (dates.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.offset),
        child: Center(
          child: Text.rich(TextSpan(children: [
            const TextSpan(
              text: "It looks like you don't have any entries\nAdd an entry to get started ",
              style: TextStyles.body1,
            ),
            EmojiTextSpan(
              text: "😊",
              style: TextStyles.body1,
            ),
          ]), textAlign: TextAlign.center,),
        ),
      );
    }

    final List<Widget> children = [];

    DateTime? previousDate;
    for (DateTime date in dates) {
      if (previousDate == null || previousDate.month != date.month) {
        children.add(Text(
          DateFormat.yMMMM().format(date),
          style: TextStyles.heading,
        ));
      } else if (!previousDate.isSameDay(date.copyWith(day: date.day - 1))) {
        children.add(Center(
          child: Text(
            "${date.difference(previousDate).inDays} days missing",
            style: TextStyles.body1.copyWith(color: AppColors.mutedColor),
          ),
        ));
      }

      children.add(EntryDetailsCard(model.entryOn(date)!));

      previousDate = date;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.offset),
      child: Consumer<MoodEntryModel>(
        builder: (_, model, __) => ListView(
          children:
              children.separate(const SizedBox(height: Insets.med)).toList(),
        ),
      ),
    );
  }
}

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

class _EntryActionButton extends StatelessWidget {
  const _EntryActionButton({Key? key}) : super(key: key);

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
