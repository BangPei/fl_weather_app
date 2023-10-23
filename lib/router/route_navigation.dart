import 'package:weather_app/common/session_manager.dart';
import 'package:weather_app/dio_injector/navigation_service.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/screen/login/login_screen.dart';
import 'package:weather_app/screen/register/register_screen.dart';
import 'package:weather_app/screen/weather/weather_screen.dart';
import 'package:weather_app/widget/widget_tree.dart';

final NavigationService _nav = locator<NavigationService>();

class RouteNavigation {
  static final GoRouter router = GoRouter(
    navigatorKey: _nav.navKey,
    initialLocation: '/splash',
    redirect: (context, state) async {
      bool? val = await Session.checkValue("user");
      if (!val) {
        return '/auth';
      } else {
        return '/';
      }
    },
    routes: [
      GoRoute(
        parentNavigatorKey: _nav.navKey,
        path: '/splash',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: WidgetTree(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _nav.navKey,
        path: '/auth',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _nav.navKey,
        path: '/register',
        name: 'register',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: RegisterScreen(),
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
