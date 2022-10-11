import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/constants.dart';
import 'package:mood_tracker/screens/edit_entry_screen/entry_template.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/color_utils.dart';
import 'package:mood_tracker/utils/date_time_utils.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/animations/implicit.dart';
import 'package:mood_tracker/widgets/buttons/styled_icon_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:mood_tracker/widgets/custom_slider.dart';
import 'package:mood_tracker/widgets/modal_sheet.dart';
import 'package:mood_tracker/widgets/outlined_text.dart';
import 'package:provider/provider.dart';

import 'entry_detail_view.dart';

class EntryMoodView extends StatelessWidget {
  const EntryMoodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final template = context.read<EntryTemplate>();

    return CustomScaffold(
      resizeToAvoidBottomInset: false,
      leading: StyledIconButton(
        icon: Icons.close_rounded,
        onTap: () => context.pop(rootNavigator: true),
      ),
      bottomActionButton: ActionButton(
        onTap: () => context.push(const EntryDetailView()),
        color: AppColors.contrastColor,
        label: "Continue",
        icon: Icons.arrow_forward_rounded,
      ),
      child: Column(
        children: [
          Expanded(child: _MoodHeading(initialTimestamp: template.timestamp)),
          StatefulBuilder(
            builder: (_, setState) => _MoodSelector(
              mood: template.mood,
              onMoodChanged: (newMood) =>
                  setState(() => template.mood = newMood),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _MoodHeading extends StatefulWidget {
  final DateTime initialTimestamp;

  const _MoodHeading({Key? key, required this.initialTimestamp})
      : super(key: key);

  @override
  State<_MoodHeading> createState() => _MoodHeadingState();
}

class _MoodHeadingState extends State<_MoodHeading> {
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
      builder: (_) => _DateSelector(initialDateTime: _timestamp),
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

class _DateSelector extends StatefulWidget {
  final DateTime initialDateTime;

  const _DateSelector({
    Key? key,
    required this.initialDateTime,
  }) : super(key: key);

  @override
  State<_DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<_DateSelector> {
  late DateTime _selectedDateTime = widget.initialDateTime;

  @override
  Widget build(BuildContext context) {
    return ModalSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leftAction: CupertinoButton(
        child: const Text("Cancel", style: TextStyles.title),
        onPressed: () => context.pop(),
      ),
      rightAction: CupertinoButton(
        child: const Text("Done", style: TextStyles.title),
        onPressed: () => context.pop(result: _selectedDateTime),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: CupertinoDatePicker(
          maximumDate: DateTime.now(),
          initialDateTime: widget.initialDateTime,
          onDateTimeChanged: (date) {
            HapticFeedback.lightImpact();
            setState(() => _selectedDateTime = date);
          },
        ),
      ),
    );
  }
}

class _MoodSelector extends StatelessWidget {
  final int mood;
  final ValueChanged<int> onMoodChanged;

  const _MoodSelector({
    Key? key,
    required this.mood,
    required this.onMoodChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedText(
          "${mood % 1 == 0 ? mood.toInt() : mood}",
          strokeColor: AppColors.contrastColor,
          strokeWidth: 2,
          style: TextStyle(
            fontSize: 175,
            color: colorFromMood(mood),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Insets.sm),
        CustomSlider(
          value: mood / Constants.maxMood,
          trackColor: colorFromMood(mood),
          borderColor: AppColors.contrastColor,
          divisions: Constants.maxMood.toInt(),
          onChanged: (value) => onMoodChanged(
            (value * Constants.maxMood).toInt(),
          ),
        ),
      ],
    );
  }
}
