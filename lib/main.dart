import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parchment/bootstrapper.dart';
import 'package:parchment/router.dart';

import 'package:parchment/theme.dart';
import 'package:provider/provider.dart';

import 'models/mood_entry_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Bootstrapper.bootstrap();

  runApp(ChangeNotifierProvider<MoodEntryModel>(
    create: (_) => MoodEntryModel(),
    child: const ParchmentApp(),
  ));
}

class ParchmentApp extends StatelessWidget {
  const ParchmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MaterialApp.router(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter().router,
      ),
    );
  }
}
