import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/modal_sheet.dart';

class DateSelector extends StatefulWidget {
  final DateTime initialDateTime;

  const DateSelector({
    Key? key,
    required this.initialDateTime,
  }) : super(key: key);

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime _selectedDateTime = widget.initialDateTime;

  @override
  Widget build(BuildContext context) {
    return ModalSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leftAction: CupertinoButton(
        child: Text(
          "Cancel",
          style: TextStyles.title.copyWith(fontWeight: FontWeight.normal),
        ),
        onPressed: () => context.pop(),
      ),
      rightAction: CupertinoButton(
        child: const Text("Done", style: TextStyles.title),
        onPressed: () => context.pop(result: _selectedDateTime),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: CupertinoTheme(
          data: const CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: TextStyles.title,
            ),
          ),
          child: CupertinoDatePicker(
            maximumDate: DateTime.now(),
            initialDateTime: widget.initialDateTime,
            onDateTimeChanged: (date) {
              HapticFeedback.selectionClick();
              setState(() => _selectedDateTime = date);
            },
          ),
        ),
      ),
    );
  }
}
