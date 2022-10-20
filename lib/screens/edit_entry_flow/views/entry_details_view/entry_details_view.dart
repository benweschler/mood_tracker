import 'package:flutter/material.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/screens/edit_entry_flow/entry_template.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/buttons/action_button.dart';
import 'package:mood_tracker/widgets/buttons/styled_icon_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

import 'components/entry_details_form.dart';

class EntryDetailsView extends StatelessWidget {
  const EntryDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: StyledIconButton(
        icon: Icons.arrow_back,
        onTap: context.pop,
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
                    onTap: () {
                      context
                          .read<MoodEntryModel>()
                          .addEntry(context.read<EntryTemplate>().toEntry());
                      context.pop(rootNavigator: true);
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
