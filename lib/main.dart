import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/router/route_navigation.dart';
import 'package:weather_app/screen/home/bloc/weather_bloc.dart';

void main() async {
  setPathUrlStrategy();
  setupLocator();
  await Jiffy.setLocale('id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(create: (__) => WeatherBloc()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: RouteNavigation.router,
      ),
    );
  }
}
