import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minute_player/screens/favourite_screen.dart';
import 'package:minute_player/screens/folders_screen.dart';
import 'package:minute_player/screens/home_screen.dart';
import 'package:minute_player/screens/settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'folders');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'settings');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'favourites');

final router = GoRouter(
  initialLocation: '/folders',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                  path: '/folders',
                  pageBuilder: (context, state) => const NoTransitionPage(
                        child: FolderScreen(),
                      ),
                  routes: const [] //subRoutes here
                  )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCKey,
            routes: [
              GoRoute(
                  path: '/favourites',
                  pageBuilder: (context, state) => const NoTransitionPage(
                        child: FavouriteScreen(),
                      ),
                  routes: const [] //subRoutes here
                  )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                  path: '/settings',
                  pageBuilder: (context, state) => const NoTransitionPage(
                        child: SettingsScreen(),
                      ),
                  routes: const [] //subRoutes here
                  )
            ],
          )
        ]),
  ],
);
