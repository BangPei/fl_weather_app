import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/full_weather.dart';

class Forecast {
  String? cod;
  int? message;
  int? cnt;
  List<FullWeather>? list;
  City? city;

  Forecast({this.cod, this.message, this.cnt, this.list, this.city});

  Forecast.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <FullWeather>[];
      json['list'].forEach((v) {
        list!.add(FullWeather.fromJson(v));
      });
    }
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}
