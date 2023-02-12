import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/screens/edit_entry_flow/edit_entry_wrapper.dart';
import 'package:parchment/screens/edit_entry_flow/entry_details_view/entry_details_view.dart';
import 'package:parchment/screens/edit_entry_flow/entry_mood_view/entry_mood_view.dart';
import 'package:parchment/screens/home/home.dart';
import 'package:parchment/screens/settings.dart';

import 'data/mood_entry.dart';
import 'main_app_scaffold.dart';

class AppRouter {
  // Private navigators
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter get appRouter => GoRouter(
        initialLocation: "/",
        navigatorKey: _rootNavigatorKey,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => MainAppScaffold(body: child),
            routes: [
              GoRoute(
                path: "/",
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
                routes: [
                  GoRoute(
                    name: "edit_entry",
                    path: "edit_entry",
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) => MaterialPage(
                      child: EditEntryWrapper(
                        entry: state.extra as MoodEntry?,
                        child: const EntryMoodView(),
                      ),
                      fullscreenDialog: true,
                    ),
                  ),
                  GoRoute(
                    name: "entry_details",
                    path: "entry_details",
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => EditEntryWrapper(
                      entry: state.extra as MoodEntry?,
                      child: const EntryDetailsView(),
                    ),
                  ),
                ],
              ),
              GoRoute(
                name: "/settings",
                path: "/settings",
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsScreen(),
                ),
              ),
              GoRoute(
                name: "/logger",
                path: "/logger",
                builder: (context, state) => const LoggerView(),
              ),
            ],
          ),
        ],
      );
}
