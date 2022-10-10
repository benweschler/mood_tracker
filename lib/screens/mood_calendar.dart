import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/mood_entry.dart';

class MoodCalendar extends StatelessWidget {
  final ValueChanged<DateTime?> onDateTapped;

  const MoodCalendar({
    Key? key,
    required this.onDateTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar<MoodEntry>(
      focusedDay: context.select<MoodEntryModel, DateTime>(
        (model) => model.dates.reduce((a, b) => a.isAfter(b) ? a : b),
      ),
      firstDay: context.select<MoodEntryModel, DateTime>(
        (model) => model.dates.reduce((a, b) => a.isBefore(b) ? a : b),
      ),
      lastDay: DateTime.now(),
      onDaySelected: (selectedDay, _) {
        if (context.read<MoodEntryModel>().entryOn(selectedDay) == null) return;
        onDateTapped(selectedDay);
      },
      availableCalendarFormats: const {CalendarFormat.month: "Month"},
      availableGestures: AvailableGestures.horizontalSwipe,
      weekendDays: const [],
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        leftChevronMargin: EdgeInsets.zero,
        leftChevronPadding: EdgeInsets.zero,
        rightChevronMargin: EdgeInsets.zero,
        rightChevronPadding: EdgeInsets.zero,
        leftChevronIcon: Icon(
          Icons.chevron_left_rounded,
          color: AppColors.contrastColor,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right_rounded,
          color: AppColors.contrastColor,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyles.body.copyWith(
          color: TextStyles.captionColor,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        prioritizedBuilder: (context, day, ___) => _cellBuilder(context, day),
        headerTitleBuilder: (_, focusedMonth) => _headerBuilder(focusedMonth),
      ),
      calendarStyle: const CalendarStyle(
        markerSizeScale: 30,
        todayDecoration: BoxDecoration(),
      ),
    );
  }

  Widget _headerBuilder(DateTime focusedMonth) {
    final title = DateFormat.yMMMM().format(focusedMonth).split(" ");

    return Text.rich(TextSpan(children: [
      TextSpan(
        text: "${title[0]} ",
        style: TextStyles.title,
      ),
      TextSpan(
        text: title[1],
        style: TextStyles.title.copyWith(fontWeight: FontWeight.normal),
      ),
    ]));
  }

  Widget _cellBuilder(BuildContext context, DateTime day) {
    final content = Text("${day.day}", style: TextStyles.body);
    final mood = context
        .select<MoodEntryModel, MoodEntry?>((model) => model.entryOn(day))
        ?.mood;

    if (mood == null) return Center(child: content);

    final bool isSelected =
        context.select<DateTime?, bool>((selectedDay) => selectedDay == day);

    return Padding(
      padding: const EdgeInsets.all(Insets.xs),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.contrastColor,
              width: isSelected ? 2 : 1,
            ),
            color: colorFromMood(mood),
            borderRadius: Corners.medBorderRadius,
          ),
          child: Center(
            child: isSelected
                ? Text(
                    content.data!,
                    style: content.style!.copyWith(fontWeight: FontWeight.w600),
                  )
                : content,
          ),
        ),
      ),
    );
  }
}
