import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/models/full_weather.dart';
import 'package:weather_app/screen/home/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<WeatherBloc>().add(const GetWeather());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: (state.forecast?.list ?? []).length,
            itemBuilder: (context, i) {
              FullWeather weather = state.forecast?.list?[i] ?? FullWeather();
              return ListTile(
                title: Text(Jiffy.parse(weather.dtTxt!)
                    .format(pattern: "EEEE, dd MMMM yyyy HH:mm:ss")),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
