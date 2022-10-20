import 'package:flutter/cupertino.dart';
import 'package:mood_tracker/data/mood_entry.dart';
import 'package:mood_tracker/screens/edit_entry_flow/views/entry_mood_view/entry_mood_view.dart';
import 'package:mood_tracker/utils/navigation_utils.dart';
import 'package:provider/provider.dart';

import 'entry_template.dart';

class EditEntryWrapper extends StatelessWidget {
  final MoodEntry? entry;

  const EditEntryWrapper({Key? key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EntryTemplate>(
      create: (_) => EntryTemplate.fromEntry(entry),
      child: Navigator(
        onGenerateRoute: (_) => convertToRoute(const EntryMoodView()),
        observers: [HeroController()],
      ),
    );
  }
}
