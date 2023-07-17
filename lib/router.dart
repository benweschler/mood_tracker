import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/screens/edit_entry_flow/edit_entry_wrapper.dart';
import 'package:parchment/screens/home/home.dart';
import 'package:parchment/screens/logger.dart';
import 'package:parchment/screens/settings.dart';

import 'data/mood_entry.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            path: "/",
            name: "home",
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
            routes: [
              GoRoute(
                path: "edit-entry",
                name: "edit-entry",
                pageBuilder: (context, state) => CupertinoPage(
                  child: EditEntryWrapper(entry: state.extra as MoodEntry?),
                  fullscreenDialog: true,
                ),
              ),
              GoRoute(
                path: "settings",
                name: "settings",
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  GoRoute(
                    path: "logger",
                    name: "logger",
                    builder: (context, state) => const LoggerView(),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
