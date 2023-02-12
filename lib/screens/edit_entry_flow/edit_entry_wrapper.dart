import 'package:flutter/cupertino.dart';
import 'package:parchment/data/mood_entry.dart';
import 'package:provider/provider.dart';

import 'entry_template.dart';

class EditEntryWrapper extends StatelessWidget {
  final MoodEntry? entry;
  final Widget child;

  const EditEntryWrapper({
    Key? key,
    this.entry,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EntryTemplate>(
      create: (_) => EntryTemplate.fromEntry(entry),
      child: child,
    );
  }
}
