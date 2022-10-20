import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/constants.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/models/mood_entry_model.dart';
import 'package:mood_tracker/screens/edit_entry_flow/edit_entry_wrapper.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/color_utils.dart';
import 'package:mood_tracker/utils/iterable_utils.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:mood_tracker/widgets/modal_sheet.dart';
import 'package:provider/provider.dart';

class EntryDetailsCard extends StatelessWidget {
  final MoodEntry entry;

  const EntryDetailsCard(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => EntryContextMenu(entry),
      ),
      child: Container(
        padding: const EdgeInsets.all(Insets.med),
        decoration: BoxDecoration(
          color: colorFromMood(entry.mood),
          border: Border.all(color: AppColors.contrastColor, width: 1),
          borderRadius: Corners.medBorderRadius,
        ),
        child: Stack(
          children: [
            _CardContent(entry),
            Positioned(
              bottom: 0,
              right: 0,
              child: Transform.rotate(
                angle: pi / 2,
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: TextStyles.captionColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final MoodEntry entry;

  const _CardContent(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            const Visibility(
              visible: false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              maintainInteractivity: false,
              child: Text("${Constants.maxMood}", style: TextStyles.heading),
            ),
            Positioned.fill(
              child: Center(
                child: Text("${entry.mood}", style: TextStyles.heading),
              ),
            ),
          ],
        ),
        const SizedBox(width: Insets.med),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.MMMMEEEEd()
                    .add_jm()
                    .format(entry.timestamp)
                    .toUpperCase(),
                style: TextStyles.body2.copyWith(
                  color: TextStyles.captionColor,
                ),
              ),
              const SizedBox(height: Insets.sm),
              Row(
                children: [
                  Icon(
                    Icons.bedtime_rounded,
                    color: AppColors.contrastColor,
                    size: TextStyles.title.fontSize,
                  ),
                  const SizedBox(width: Insets.xs),
                  _buildSleepText(entry.sleep),
                ],
              ),
              if (entry.description.isNotEmpty) ...[
                const SizedBox(height: Insets.lg),
                Text(
                  entry.description,
                  style: TextStyles.title.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSleepText(Duration sleep) {
    final statStyle = TextStyles.title.copyWith(fontWeight: FontWeight.normal);
    if (sleep == Duration.zero) {
      return Text("All-nighter", style: statStyle.copyWith(fontSize: 16));
    }

    const unitStyle = TextStyles.body2;
    const TextSpan unitSpacer =
        TextSpan(text: " ", style: TextStyle(fontSize: 10));
    final int hours = sleep.inHours;
    final int minutes = sleep.inMinutes.remainder(60);
    final List<TextSpan> spans = [];

    if (hours != 0) {
      spans.add(TextSpan(text: "$hours", style: statStyle));
      spans.add(unitSpacer);
      spans.add(const TextSpan(text: "hr", style: unitStyle));
    }
    if (minutes != 0) {
      if (hours != 0) {
        spans.add(TextSpan(text: " ", style: statStyle));
      }
      spans.add(TextSpan(text: "$minutes", style: statStyle));
      spans.add(unitSpacer);
      spans.add(const TextSpan(text: "min", style: unitStyle));
    }

    return Text.rich(TextSpan(children: spans));
  }
}

class EntryContextMenu extends StatelessWidget {
  final MoodEntry entry;

  const EntryContextMenu(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.offset,
          vertical: Insets.lg,
        ),
        child: Column(
          children: <Widget>[
            ContextMenuAction(
              icon: Icons.edit_rounded,
              label: "Edit",
              onTap: () {
                context.pop();
                context.push(
                  EditEntryWrapper(entry: entry),
                  fullscreenDialog: true,
                );
              },
            ),
            ContextMenuAction(
              icon: Icons.delete_rounded,
              label: "Delete",
              onTap: () {
                context.read<MoodEntryModel>().removeEntry(entry);
                context.pop();
              },
            ),
            ContextMenuAction(
              icon: Icons.close_rounded,
              label: "Close",
              onTap: context.pop,
            ),
          ].separate(const SizedBox(height: Insets.lg)).toList(),
        ),
      ),
    );
  }
}

class ContextMenuAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final GestureTapCallback? onTap;

  const ContextMenuAction({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: Insets.lg),
          Text(
            label,
            style: TextStyles.title.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
