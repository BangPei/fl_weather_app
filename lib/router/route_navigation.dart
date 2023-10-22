import 'package:flutter/material.dart';
import 'package:weather_app/dio_injector/navigation_service.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/screen/login/login_register_screen.dart';
import 'package:weather_app/screen/weather/weather_screen.dart';

final NavigationService _nav = locator<NavigationService>();

class RouteNavigation {
  static final GoRouter router = GoRouter(
    navigatorKey: _nav.navKey,
    initialLocation: '/auth',
    redirect: (context, state) async {
      // // String? token = await Session.get("token");
      // if (token == null || token == "") {
      //   return '/auth';
      // } else {
      //   return null;
      // }
      return null;
    },
    routes: [
      GoRoute(
        parentNavigatorKey: _nav.navKey,
        path: '/auth',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: LoginRegisterScreen(),
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
