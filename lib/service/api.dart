import 'package:dio/dio.dart';
import 'package:weather_app/dio_injector/dio_interceptor.dart';
import 'package:weather_app/service/restclient.dart';

class Api {
  // static const String baseUrl = "http://192.168.0.163:3000/api/";
  // static const String baseUrl = "http://192.168.100.11:3000/api/";
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/";

  static Map<String, dynamic> params = {
    "appid": "07f0f3426a5a18188d7acfcc10b4fc38"
  };

  static restClient() async {
    final dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(DioInterceptors(dio));
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Accept"] = "*/*";
    dio.options.queryParameters = params;
    return RestClient(dio, baseUrl: baseUrl);
  }
}
