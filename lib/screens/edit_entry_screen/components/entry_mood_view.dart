import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/constants.dart';
import 'package:mood_tracker/screens/edit_entry_screen/entry_template.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/buttons/styled_icon_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:mood_tracker/widgets/custom_slider.dart';
import 'package:mood_tracker/widgets/outlined_text.dart';
import 'package:provider/provider.dart';

import 'entry_detail_view.dart';

class EntryMoodView extends StatefulWidget {
  const EntryMoodView({Key? key}) : super(key: key);

  @override
  State<EntryMoodView> createState() => _EntryMoodViewState();
}

class _EntryMoodViewState extends State<EntryMoodView> {
  late int mood = context.read<EntryTemplate>().mood;
  late DateTime timestamp = context.read<EntryTemplate>().timestamp;

  @override
  Widget build(BuildContext context) {
    final continueButton = ActionButton(
      onTap: () => context.push(const EntryDetailView()),
      color: AppColors.contrastColor,
      label: "Continue",
      icon: Icons.arrow_forward_rounded,
    );

    return CustomScaffold(
      leading: StyledIconButton(
        icon: Icons.close_rounded,
        onTap: () => context.pop(rootNavigator: true),
      ),
      bottomActionButton: continueButton,
      child: Column(
        children: [
          Expanded(child: _MoodHeading(timestamp: timestamp)),
          StatefulBuilder(
            builder: (_, setState) => _MoodSelector(
              mood: mood,
              onMoodChanged: (newMood) => setState(() => mood = newMood),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _MoodHeading extends StatelessWidget {
  final DateTime timestamp;

  const _MoodHeading({Key? key, required this.timestamp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("How are you?", style: TextStyles.heading),
        const SizedBox(height: Insets.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today, color: AppColors.contrastColor),
            const SizedBox(width: Insets.sm),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: TextStyles.textColor)),
              ),
              child: Text(
                "Today, ${DateFormat.MMMd().format(timestamp)} at ${DateFormat.jm().format(timestamp)}",
                style: TextStyles.title.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ],
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
