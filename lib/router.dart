import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/screens/home/home.dart';
import 'package:parchment/screens/settings.dart';

import 'main_app_scaffold.dart';

class AppRouter {
  // Private navigators
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter get appRouter => GoRouter(
        initialLocation: "/home",
        navigatorKey: _rootNavigatorKey,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => MainAppScaffold(body: child),
            routes: [
              GoRoute(
                path: "/home",
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle.dark,
                    child: HomeScreen(),
                  ),
                ),
              ),
              GoRoute(
                path: "/settings",
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsScreen(),
                ),
              ),
            ],
          ),
        ],
      );
}
