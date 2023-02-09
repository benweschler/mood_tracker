import 'package:flutter/material.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/screens/edit_entry_flow/entry_template.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/date_time_utils.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/buttons/action_button.dart';
import 'package:mood_tracker/widgets/buttons/responsive_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:mood_tracker/widgets/platform_aware/platform_alert_dialog.dart';
import 'package:mood_tracker/widgets/styled_icon.dart';
import 'package:provider/provider.dart';

import 'components/entry_details_form.dart';

class EntryDetailsView extends StatelessWidget {
  const EntryDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: ResponsiveStrokeButton(
        onTap: context.pop,
        child: const StyledIcon(
          icon: Icons.arrow_back,
          color: AppColors.contrastColor,
        ),
      ),
      child: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight +
                  MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const EntryDetailsForm(),
                const SizedBox(height: Insets.lg),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Insets.offset +
                        MediaQuery.of(context).viewPadding.bottom,
                  ),
                  child: ActionButton(
                    onTap: () async {
                      final template = context.read<EntryTemplate>();
                      final model = context.read<MoodEntryModel>();
                      pop() => context.pop(rootNavigator: true);

                      if(model.dates.contains(template.timestamp.toDate())) {
                        final confirmation = await showPlatformDialog(
                          context: context,
                          dialog: const PlatformAlertDialog(
                            title: "Overwrite Entry",
                            content:
                            "There's already an entry on this day. Are you sure you want to overwrite it?",
                            confirmText: "Yes",
                            cancelText: "No",
                            isDestructiveAction: true,
                          ),
                        );

                        if(!confirmation) return;
                      }
                      model.addEntry(template.toEntry());
                      pop();
                    },
                    color: AppColors.contrastColor,
                    label: "Save",
                    icon: Icons.done_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
