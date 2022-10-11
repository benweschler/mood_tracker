import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/date_time_utils.dart';
import 'package:mood_tracker/widgets/animations/implicit.dart';

import 'date_selector.dart';

class MoodHeading extends StatefulWidget {
  final DateTime initialTimestamp;

  const MoodHeading({Key? key, required this.initialTimestamp})
      : super(key: key);

  @override
  State<MoodHeading> createState() => MoodHeadingState();
}

class MoodHeadingState extends State<MoodHeading> {
  late DateTime _timestamp = widget.initialTimestamp;
  late bool _timestampIsToday;

  @override
  Widget build(BuildContext context) {
    _timestampIsToday = _timestamp.isSameDay(DateTime.now());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedFadeTransition(
          firstChild: const Text("How are you?", style: TextStyles.heading),
          secondChild: const Text("How were you?", style: TextStyles.heading),
          crossFadeState: _timestampIsToday
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Durations.universal,
        ),
        const SizedBox(height: Insets.sm),
        const SizedBox(height: Insets.sm),
        GestureDetector(
          onTap: _chooseDate,
          child: AnimatedSingleChildUpdate(
            childKey: ValueKey(_buildDateText()),
            duration: Durations.universal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today,
                    color: AppColors.contrastColor),
                const SizedBox(width: Insets.sm),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.contrastColor),
                    ),
                  ),
                  child: Text(
                    _buildDateText(),
                    style: TextStyles.title.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _chooseDate() async {
    final DateTime? newDate = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => DateSelector(initialDateTime: _timestamp),
    );

    if (newDate != null) {
      setState(() => _timestamp = newDate);
    }
  }

  String _buildDateText() {
    final String day =
    _timestampIsToday ? "Today" : DateFormat.EEEE().format(_timestamp);
    return "$day, ${DateFormat.MMMd().format(_timestamp)} at ${DateFormat.jm().format(_timestamp)}";
  }
}