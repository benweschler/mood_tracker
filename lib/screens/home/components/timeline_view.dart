import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parchment/data/mood_entry.dart';
import 'package:parchment/models/mood_entry_model.dart';
import 'package:parchment/styles.dart';
import 'package:parchment/utils/date_time_utils.dart';
import 'package:parchment/utils/emoji_text_span.dart';
import 'package:provider/provider.dart';

import 'entry_card.dart';

class TimelineView extends StatelessWidget {
  const TimelineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.offset),
      child: Consumer<MoodEntryModel>(
        builder: (_, model, __) {
          final List<DateTime> dates = model.dates.toList()
            ..sort((a, b) => b.compareTo(a));
          if (dates.isEmpty) return _buildNoEntryMessage();

          return ListView.builder(
            itemCount: dates.length + 1,
            itemBuilder: (_, index) {
              //TODO: this is a hacky way to ensure that the ListView is not obscured by the overlaid action button.
              if (index == dates.length) {
                final bottomPadding = SizedBox(
                  height: MediaQuery.of(context).viewPadding.bottom + 50,
                );
                return bottomPadding;
              }

              getEntry(day) => model.entryOn(day);
              return _buildTimelineElement(index, dates, getEntry);
            },
          );
        },
      ),
    );
  }

  Widget _buildTimelineElement(
      int index, List<DateTime> dates, MoodEntry? Function(DateTime) getEntry) {
    final List<Widget> children = [];
    final DateTime date = dates[index];
    final DateTime? previousDate = index > 0 ? dates[index - 1] : null;

    if (previousDate == null || previousDate.month != date.month) {
      //TODO: add year to heading if not current year.
      children.add(Text(
        "${DateFormat.MMMM().format(date)} ",
        style: TextStyles.heading.copyWith(fontWeight: FontWeight.bold),
      ));
    } else if (previousDate.isSameDay(date.copyWith(day: date.day - 1))) {
      children.add(Center(
        child: Text(
          "${date.difference(previousDate).inDays} days missing",
          style: TextStyles.body1.copyWith(color: AppColors.mutedColor),
        ),
      ));
    }

    children.add(EntryDetailsCard(getEntry(date)!));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children
          .expand((element) => [element, const SizedBox(height: Insets.med)])
          .toList(),
    );
  }

  Widget _buildNoEntryMessage() {
    return Center(
      child: Text.rich(
        TextSpan(children: [
          const TextSpan(
            text:
            "It looks like you don't have any entries\nAdd an entry to get started ",
            style: TextStyles.body1,
          ),
          EmojiTextSpan(
            text: "😊",
            style: TextStyles.body1,
          ),
        ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
