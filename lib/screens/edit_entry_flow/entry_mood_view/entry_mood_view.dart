import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/screens/edit_entry_flow/entry_details_view/entry_details_view.dart';
import 'package:parchment/screens/edit_entry_flow/entry_template.dart';
import 'package:parchment/styles.dart';
import 'package:parchment/widgets/buttons/action_button.dart';
import 'package:parchment/widgets/buttons/responsive_button.dart';
import 'package:parchment/widgets/custom_scaffold.dart';
import 'package:parchment/widgets/styled_icon.dart';
import 'package:provider/provider.dart';

import 'components/mood_heading.dart';
import 'components/mood_selector.dart';

class EntryMoodView extends StatelessWidget {
  const EntryMoodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: false,
      leading: ResponsiveStrokeButton(
        onTap: context.pop,
        child: const StyledIcon(
          icon: Icons.close_rounded,
          color: AppColors.contrastColor,
        ),
      ),
      bottomActionButton: ActionButton(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const EntryDetailsView()),
        ),
        color: AppColors.contrastColor,
        label: "Continue",
        icon: Icons.arrow_forward_rounded,
      ),
      child: Consumer<EntryTemplate>(
        builder: (_, template, __) => Column(
          children: [
            Expanded(child: MoodHeading(timestamp: template.timestamp)),
            MoodSelector(
              mood: template.mood,
              onMoodChanged: (newMood) => template.mood = newMood,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
