import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/full_weather.dart';
import 'package:weather_app/screen/weather/bloc/weather_bloc.dart';
import 'package:weather_app/screen/weather/weather_details.dart';
import 'package:weather_app/widget/loading_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    context.read<WeatherBloc>().add(const GetWeather());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          Forecast forecast = state.forecast ?? Forecast();
          return (state.isLoading ?? true)
              ? const LoadingScreen()
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: size.width,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 248, 245, 245),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color.fromARGB(255, 230, 229, 229),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Welcome, ",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: state.user?.fullname ?? "User",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Center(
                              child: Text(forecast.city?.country ?? ""),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: (state.forecast?.list ?? []).length,
                      itemBuilder: (context, i) {
                        FullWeather weather =
                            forecast.list?[i] ?? FullWeather();
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WeatherDetails(data: weather),
                              ),
                            );
                          },
                          leading: Image.network(
                              'https://openweathermap.org/img/wn/${weather.weather?[0].icon}.png'),
                          title: Text(
                            Jiffy.parse(weather.dtTxt!).yMMMEdjm,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(weather.weather?[0].main ?? ""),
                              Text(
                                  "Temp : ${(weather.main?.temp ?? 0).toString()}\u2103"),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }
}
