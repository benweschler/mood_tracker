import 'package:flutter/material.dart';
import 'package:mood_tracker/screens/edit_entry_flow/entry_template.dart';
import 'package:mood_tracker/screens/edit_entry_flow/views/entry_details_view/entry_details_view.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/buttons/styled_icon_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

import 'components/mood_heading.dart';
import 'components/mood_selector.dart';

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
        onTap: () => context.push(const EntryDetailsView()),
        color: AppColors.contrastColor,
        label: "Continue",
        icon: Icons.arrow_forward_rounded,
      ),
      child: Column(
        children: [
          Expanded(child: MoodHeading(initialTimestamp: template.timestamp)),
          StatefulBuilder(
            builder: (_, setState) => MoodSelector(
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