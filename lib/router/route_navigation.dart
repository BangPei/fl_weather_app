import 'package:flutter/material.dart';
import 'package:weather_app/dio_injector/navigation_service.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/screen/home/weather_screen.dart';

final NavigationService _nav = locator<NavigationService>();
final GlobalKey<NavigatorState> _homeNav =
    GlobalKey<NavigatorState>(debugLabel: 'dashboard');

class RouteNavigation {
  static final GoRouter router = GoRouter(
    navigatorKey: _nav.navKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        parentNavigatorKey: _nav.navKey,
        path: '/auth',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: Scaffold(),
          );
        },
      ),
      GoRoute(
        // parentNavigatorKey: _homeNav,
        path: '/',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: WeatherScreen(),
          );
        },
      ),
    ],
  );
}
