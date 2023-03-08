import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/screens/edit_entry_flow/edit_entry_wrapper.dart';
import 'package:parchment/screens/home/home.dart';
import 'package:parchment/screens/logger.dart';
import 'package:parchment/screens/settings.dart';

import 'main_app_scaffold.dart';

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter get appRouter => GoRouter(
        initialLocation: "/",
        navigatorKey: _rootNavigatorKey,
        observers: [HeroController()],
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => MainAppScaffold(body: child),
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
                    pageBuilder: (context, state) => const CupertinoPage(
                      child: EditEntryWrapper(),
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
          ),
        ],
      );
}
