import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/models/full_weather.dart';

class WeatherDetails extends StatelessWidget {
  final FullWeather data;
  const WeatherDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Text(
                Jiffy.parse(data.dtTxt!).yMMMMEEEEd,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
              Text(
                Jiffy.parse(data.dtTxt!).jm,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(data.main?.temp ?? 0).toString()}\u2103",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Image.network(
                      'https://openweathermap.org/img/wn/${data.weather?[0].icon}.png',
                      scale: 0.3,
                    )
                  ],
                ),
              ),
              Text(
                "${data.weather?[0].main} (${data.weather?[0].description})",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Temp (min)",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${(data.main?.tempMin ?? 0).toString()}\u2103",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Temp (max)",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${(data.main?.tempMax ?? 0).toString()}\u2103",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
