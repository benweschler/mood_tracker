import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/screens/edit_entry_flow/entry_template.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/date_time_utils.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/animations/implicit.dart';
import 'package:mood_tracker/widgets/buttons/responsive_button.dart';
import 'package:provider/provider.dart';

import 'date_selector.dart';

class MoodHeading extends StatelessWidget {
  final DateTime timestamp;

  const MoodHeading({Key? key, required this.timestamp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTimestampToday = timestamp.isSameDay(DateTime.now());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedFadeTransition(
          firstChild: const Text("How are you?", style: TextStyles.heading),
          secondChild: const Text("How were you?", style: TextStyles.heading),
          crossFadeState: isTimestampToday
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Durations.med,
        ),
        const SizedBox(height: Insets.sm),
        ResponsiveStrokeButton(
          onTap: () => _chooseDate(context),
          child: Padding(
            padding: const EdgeInsets.all(Insets.sm),
            child: AnimatedSingleChildUpdate(
              key: UniqueKey(),
              childKey: ValueKey(_buildDateText(isTimestampToday)),
              duration: Durations.med,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: AppColors.contrastColor,
                  ),
                  const SizedBox(width: Insets.sm),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.contrastColor),
                      ),
                    ),
                    child: Text(
                      _buildDateText(isTimestampToday),
                      style: TextStyles.title.copyWith(
                        color: AppColors.contrastColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _chooseDate(BuildContext context) async {
    final template = context.read<EntryTemplate>();
    final DateTime? newDate = await context.showModal(
      DateSelector(initialDateTime: timestamp),
    );

    if (newDate != null) {
      template.timestamp = newDate;
    }
  }

  String _buildDateText(bool timestampIsToday) {
    final String day =
        timestampIsToday ? "Today" : DateFormat.EEEE().format(timestamp);
    return "$day, ${DateFormat.MMMd().format(timestamp)} at ${DateFormat.jm().format(timestamp)}";
  }
}
