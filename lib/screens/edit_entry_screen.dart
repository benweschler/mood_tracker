import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/constants.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/custom_slider.dart';
import 'package:mood_tracker/mood_entry.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils.dart';
import 'package:mood_tracker/widgets/outlined_text.dart';

class EditEntryScreen extends StatelessWidget {
  final ValueChanged<MoodEntry> createEntry;
  final MoodEntry? entry;

  const EditEntryScreen({
    Key? key,
    required this.createEntry,
    this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: Insets.offset),
        child: Stack(
          children: [
            const EditMoodView(),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.contrastColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.contrastColor,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: Insets.offset,
              child: ActionButton(
                onTap: () {},
                color: AppColors.contrastColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Continue",
                      style: TextStyles.title.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    const SizedBox(width: Insets.med),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditMoodView extends StatefulWidget {
  const EditMoodView({Key? key}) : super(key: key);

  @override
  State<EditMoodView> createState() => _EditMoodViewState();
}

class _EditMoodViewState extends State<EditMoodView> {
  double mood = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: _Heading()),
        StatefulBuilder(
          builder: (_, setState) => _MoodSelector(
            mood: mood,
            onMoodChanged: (newMood) => setState(() => mood = newMood),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("How are you?", style: TextStyles.heading),
        const SizedBox(height: Insets.med),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today, color: AppColors.contrastColor),
            const SizedBox(width: Insets.med),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: TextStyles.textColor)),
              ),
              child: Text(
                "Today, ${DateFormat.MMMd().format(DateTime.now())} at ${DateFormat.jm().format(DateTime.now())}",
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
  final double mood;
  final ValueChanged<double> onMoodChanged;

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
        const SizedBox(height: Insets.med),
        CustomSlider(
          value: mood / Constants.maxMood,
          trackColor: colorFromMood(mood),
          borderColor: AppColors.contrastColor,
          divisions: Constants.maxMood.toInt(),
          onChanged: (value) => onMoodChanged(value * Constants.maxMood),
        ),
      ],
    );
  }
}
