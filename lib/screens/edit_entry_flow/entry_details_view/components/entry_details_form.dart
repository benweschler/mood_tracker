import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:parchment/screens/edit_entry_flow/entry_template.dart';
import 'package:parchment/styles.dart';
import 'package:parchment/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EntryDetailsForm extends StatefulWidget {
  const EntryDetailsForm({Key? key}) : super(key: key);

  @override
  State<EntryDetailsForm> createState() => _EntryDetailsFormState();
}

class _EntryDetailsFormState extends State<EntryDetailsForm> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "How was your day?",
            style: TextStyles.heading,
          ),
        ),
        const SizedBox(height: Insets.lg),
        Text(
          "How many hours of sleep did you get?",
          style: TextStyles.title.copyWith(fontWeight: FontWeight.w500),
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
              HapticFeedback.selectionClick();
              _template.sleep = value;
            },
          ),
        ),
        const SizedBox(height: Insets.lg),
        Text(
          "Anything else to say about your day?",
          style: TextStyles.title.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: Insets.sm),
        CustomTextField(controller: _descriptionController),
      ],
    );
  }
}
