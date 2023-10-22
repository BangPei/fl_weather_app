import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
// import 'package:jiffy/jiffy.dart';
import 'package:weather_app/router/route_navigation.dart';
import 'package:weather_app/screen/login/bloc/login_bloc.dart';
import 'package:weather_app/screen/register/bloc/register_bloc.dart';
import 'package:weather_app/screen/weather/bloc/weather_bloc.dart';
import 'service/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setPathUrlStrategy();
  setupLocator();
  // await Jiffy.setLocale('id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(create: (__) => WeatherBloc()),
        BlocProvider<LoginBloc>(create: (__) => LoginBloc()),
        BlocProvider<RegisterBloc>(create: (__) => RegisterBloc()),
      ],
      child: MaterialApp.router(
        title: 'Weather App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          // useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: RouteNavigation.router,
      ),
    );
  }
}
