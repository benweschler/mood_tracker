import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/constants.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/buttons/styled_icon_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:mood_tracker/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EntryDetailView extends StatefulWidget {
  final int selectedMood;
  final DateTime entryTimestamp;

  const EntryDetailView({
    Key? key,
    required this.selectedMood,
    required this.entryTimestamp,
  }) : super(key: key);

  @override
  State<EntryDetailView> createState() => _EntryDetailViewState();
}

class _EntryDetailViewState extends State<EntryDetailView> {
  late Duration _sleepDuration =
      context.read<MoodEntry?>()?.sleep ?? Constants.sleepGoal;
  late final _descriptionController =
      TextEditingController(text: context.read<MoodEntry?>()?.description);

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: StyledIconButton(
        icon: Icons.arrow_back,
        onTap: context.pop,
      ),
      bottomActionButton: ActionButton(
        onTap: () {
          context.read<MoodEntryModel>().addEntry(MoodEntry(
                mood: widget.selectedMood,
                sleep: _sleepDuration,
                description: _descriptionController.text,
                timestamp: widget.entryTimestamp,
              ));
          context.pop(rootNavigator: true);
        },
        color: AppColors.contrastColor,
        label: "Save",
        icon: Icons.done_rounded,
      ),
      child: ListView(
        children: [
          const Text(
            "How many hours of sleep did you get?",
            style: TextStyles.title,
          ),
          const SizedBox(height: Insets.med),
          CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            initialTimerDuration: _sleepDuration,
            onTimerDurationChanged: (value) => _sleepDuration = value,
          ),
          const SizedBox(height: Insets.lg),
          const Text(
            "Anything else to say about your day?",
            style: TextStyles.title,
          ),
          const SizedBox(height: Insets.sm),
          CustomTextField(controller: _descriptionController),
        ],
      ),
    );
  }
}
