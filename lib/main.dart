import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parchment/bootstrapper.dart';

import 'package:parchment/theme.dart';
import 'package:provider/provider.dart';

import 'screens/home/home.dart';
import 'models/mood_entry_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Bootstrapper.bootstrap();

  final MoodEntryModel moodModel = MoodEntryModel();

  runApp(ChangeNotifierProvider<MoodEntryModel>.value(
    value: moodModel,
    child: const MoodTracker(),
  ));
}

class MoodTracker extends StatelessWidget {
  const MoodTracker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Home(),
      ),
    );
  }
}
