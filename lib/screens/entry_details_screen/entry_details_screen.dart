import 'package:flutter/material.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/mood_entry.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/widgets/custom_text_field.dart';

import 'entry_mood_view.dart';

class EntryDetailsScreen extends StatelessWidget {
  final ValueChanged<MoodEntry> createEntry;
  final MoodEntry? entry;

  const EntryDetailsScreen({
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
            const EntryMoodView(),
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

class _EditMoodDetailsView extends StatefulWidget {
  const _EditMoodDetailsView({Key? key}) : super(key: key);

  @override
  State<_EditMoodDetailsView> createState() => _EditMoodDetailsViewState();
}

class _EditMoodDetailsViewState extends State<_EditMoodDetailsView> {
  final sleepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text("How many hours of sleep did you get?", style: TextStyles.title),
        const SizedBox(height: Insets.sm),
        CustomTextField(controller: sleepController),
      ],
    );
  }
}

