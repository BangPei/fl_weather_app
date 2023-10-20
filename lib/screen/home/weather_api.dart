import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/service/api.dart';

class WeatherApi {
  static Future<Forecast> getForecast() async {
    final client = await Api.restClient();
    var data = client.getForecast();
    return data;
  }
}
