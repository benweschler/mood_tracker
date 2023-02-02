import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/data/logger.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/screens/edit_entry_flow/edit_entry_wrapper.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/date_time_utils.dart';
import 'package:mood_tracker/utils/emoji_text_span.dart';
import 'package:mood_tracker/utils/iterable_utils.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/buttons/action_button.dart';
import 'package:mood_tracker/widgets/buttons/responsive_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:mood_tracker/widgets/styled_icon.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.offset),
      child: Consumer<MoodEntryModel>(
        builder: (_, model, __) {
          final List<DateTime> dates = model.dates.toList()
            ..sort((a, b) => b.compareTo(a));
          if (dates.isEmpty) return _buildNoEntryMessage();

          return ListView.builder(
            itemCount: dates.length + 1,
            itemBuilder: (_, index) {
              //TODO: this is a hacky way to ensure that the ListView is not obscured by the overlaid action button.
              if (index == dates.length) {
                final bottomPadding = SizedBox(
                  height: MediaQuery.of(context).viewPadding.bottom + 50,
                );
                return bottomPadding;
              }

              getEntry(day) => model.entryOn(day);
              return _buildTimelineElement(index, dates, getEntry);
            },
          );
        },
      ),
    );
  }

  Widget _buildTimelineElement(
      int index, List<DateTime> dates, MoodEntry? Function(DateTime) getEntry) {
    final List<Widget> children = [];
    final DateTime date = dates[index];
    final DateTime? previousDate = index > 0 ? dates[index - 1] : null;

    if (previousDate == null || previousDate.month != date.month) {
      children.add(_buildMonthHeading(date));
    } else if (previousDate.isSameDay(date.copyWith(day: date.day - 1))) {
      children.add(Center(
        child: Text(
          "${date.difference(previousDate).inDays} days missing",
          style: TextStyles.body1.copyWith(color: AppColors.mutedColor),
        ),
      ));
    }

    children.add(EntryDetailsCard(getEntry(date)!));

    return Column(
      children: children
          .expand((element) => [element, const SizedBox(height: Insets.med)])
          .toList(),
    );
  }

  Widget _buildMonthHeading(DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
            text: "${DateFormat.MMMM().format(date)} ",
            style: TextStyles.heading.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: DateFormat.y().format(date),
            style: TextStyles.heading.copyWith(color: AppColors.mutedColor),
          ),
        ])),
        const _ShowEventLogButton(),
      ],
    );
  }

  Widget _buildNoEntryMessage() {
    return Center(
      child: Text.rich(
        TextSpan(children: [
          const TextSpan(
            text:
                "It looks like you don't have any entries\nAdd an entry to get started ",
            style: TextStyles.body1,
          ),
          EmojiTextSpan(
            text: "😊",
            style: TextStyles.body1,
          ),
        ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ShowEventLogButton extends StatelessWidget {
  const _ShowEventLogButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveStrokeButton(
      onTap: () => context.push(
        const LoggerView(),
        rootNavigator: true,
      ),
      child: const StyledIcon(
        icon: Icons.timeline,
        color: AppColors.contrastColor,
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

class LoggerView extends StatelessWidget {
  const LoggerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: ResponsiveStrokeButton(
        onTap: () => context.pop(rootNavigator: true),
        child: const StyledIcon(
          icon: Icons.arrow_back_rounded,
          color: AppColors.contrastColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Event Log", style: TextStyles.heading),
          const SizedBox(height: Insets.lg),
          ...Logger.dump
              .map<Widget>((log) => Text(log))
              .separate(const SizedBox(height: Insets.med))
              .toList()
        ],
      ),
    );
  }
}
