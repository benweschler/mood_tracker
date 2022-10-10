import 'package:flutter/cupertino.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/screens/edit_entry_screen/entry_template.dart';
import 'package:mood_tracker/utils.dart';
import 'package:provider/provider.dart';

import 'components/entry_mood_view.dart';

class EditEntryWrapper extends StatelessWidget {
  final MoodEntry? entry;

  const EditEntryWrapper({
    Key? key,
    this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<EntryTemplate>.value(
      value: EntryTemplate.fromEntry(entry),
      child: Navigator(
        onGenerateRoute: (_) => convertToRoute(const EntryMoodView()),
        observers: [HeroController()],
      ),
    );
  }
}
