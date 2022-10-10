import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/screens/edit_entry_screen/entry_template.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/buttons/styled_icon_button.dart';
import 'package:mood_tracker/widgets/custom_scaffold.dart';
import 'package:mood_tracker/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EntryDetailView extends StatefulWidget {
  const EntryDetailView({Key? key}) : super(key: key);

  @override
  State<EntryDetailView> createState() => _EntryDetailViewState();
}

class _EntryDetailViewState extends State<EntryDetailView> {
  late final _template = context.read<EntryTemplate>();
  late final _descriptionController =
      TextEditingController(text: _template.description);

  @override
  void initState() {
    _descriptionController
        .addListener(() => _template.description = _descriptionController.text);
    super.initState();
  }

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
          context
              .read<MoodEntryModel>()
              .addEntry(context.read<EntryTemplate>().toEntry());
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
            initialTimerDuration: _template.sleep,
            onTimerDurationChanged: (value) => _template.sleep = value,
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
