import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/screens/edit_entry_screen/entry_template.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
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
      child: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: constraints.maxHeight +
                    MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "How many hours of sleep did you get?",
                      style: TextStyles.title,
                    ),
                    const SizedBox(height: Insets.med),
                    CupertinoTheme(
                      data: const CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          pickerTextStyle: TextStyles.title,
                        ),
                      ),
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        minuteInterval: 15,
                        initialTimerDuration: _template.sleep,
                        onTimerDurationChanged: (value) {
                          HapticFeedback.lightImpact();
                          _template.sleep = value;
                        },
                      ),
                    ),
                    const SizedBox(height: Insets.lg),
                    Text(
                      "Anything else to say about your day?",
                      style: TextStyles.title
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: Insets.sm),
                    CustomTextField(controller: _descriptionController),
                  ],
                ),
                const SizedBox(height: Insets.lg),
                Padding(
                  padding: const EdgeInsets.only(bottom: Insets.offset),
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
