import 'package:flutter/cupertino.dart';
import 'package:parchment/data/mood_entry.dart';
import 'package:parchment/utils/navigator_utils.dart';
import 'package:provider/provider.dart';

import 'entry_mood_view/entry_mood_view.dart';
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
