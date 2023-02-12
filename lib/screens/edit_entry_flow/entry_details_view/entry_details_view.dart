import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/models/mood_entry_model.dart';
import 'package:parchment/screens/edit_entry_flow/entry_template.dart';
import 'package:parchment/styles.dart';
import 'package:parchment/utils/date_time_utils.dart';
import 'package:parchment/widgets/buttons/action_button.dart';
import 'package:parchment/widgets/buttons/responsive_button.dart';
import 'package:parchment/widgets/custom_scaffold.dart';
import 'package:parchment/widgets/platform_aware/platform_alert_dialog.dart';
import 'package:parchment/widgets/styled_icon.dart';
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
                  child: const AddEntryButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddEntryButton extends StatelessWidget {
  const AddEntryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onTap: () async {
        final template = context.read<EntryTemplate>();
        final model = context.read<MoodEntryModel>();
        final pop = context.pop;

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
    );
  }
}

