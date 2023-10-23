import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/full_weather.dart';
import 'package:weather_app/screen/weather/bloc/weather_bloc.dart';
import 'package:weather_app/screen/weather/weather_details.dart';
import 'package:weather_app/widget/loading_screen.dart';
import 'package:weather_app/common/common.dart';

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
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        Forecast forecast = state.forecast ?? Forecast();
        return (state.isLoading ?? false)
            ? const Scaffold(
                body: LoadingScreen(
                  title: "Please Wait ...",
                ),
              )
            : WillPopScope(
                onWillPop: () => Common.onWillPop(context),
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text("Weather App"),
                    actions: [
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.person),
                        iconSize: 30,
                        itemBuilder: (ctx) {
                          return [
                            PopupMenuItem<String>(
                              value: "logout",
                              child: const Text('Sign Out'),
                              onTap: () {
                                context
                                    .read<WeatherBloc>()
                                    .add(const OnSignOut());
                              },
                            ),
                          ];
                        },
                      )
                    ],
                  ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      context.read<WeatherBloc>().add(const GetWeather());
                    },
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 16,
                            bottom: 18,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 248, 245, 245),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0,
                                ),
                              ],
                              border: Border.all(
                                color: const Color.fromARGB(255, 230, 229, 229),
                              ),
                            ),
                            child: Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Welcome, ",
                                    style: const TextStyle(
                                      fontSize: 25,
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
                                const SizedBox(height: 20),
                                Text(
                                  "${forecast.city?.name ?? ""} - ${forecast.city?.country ?? ""}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextCard(
                                      data:
                                          Jiffy.parseFromMicrosecondsSinceEpoch(
                                        forecast.city!.sunrise!,
                                      ).jm,
                                      title: "Sunrise",
                                    ),
                                    TextCard(
                                      data:
                                          Jiffy.parseFromMicrosecondsSinceEpoch(
                                                  forecast.city!.sunset!)
                                              .jm,
                                      title: "Sunset",
                                    ),
                                    TextCard(
                                      data: "${forecast.city!.population!}",
                                      title: "Population",
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Card(
                            child: ListView.separated(
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
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(weather.weather?[0].main ?? ""),
                                      Text(
                                          "Temp : ${(weather.main?.temp ?? 0).toString()}\u2103"),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class TextCard extends StatelessWidget {
  final String title;
  final String data;
  const TextCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          data,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
