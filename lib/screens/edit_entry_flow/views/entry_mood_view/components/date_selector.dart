import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parchment/theme.dart';
import 'package:parchment/utils/navigation_utils.dart';
import 'package:parchment/widgets/buttons/action_button.dart';
import 'package:parchment/widgets/modal_sheets/modal_sheet.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.med),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ActionButton(
                    label: "Cancel",
                    color: AppColors.mutedColor,
                    onTap: context.pop,
                  ),
                ),
                const SizedBox(width: Insets.med),
                Expanded(
                  child: ActionButton(
                    label: "Done",
                    color: AppColors.contrastColor,
                    onTap: () => context.pop(result: _selectedDateTime),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.med),
        ],
      ),
    );
  }
}
