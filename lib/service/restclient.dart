import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:weather_app/models/forecast.dart';

part 'restclient.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("forecast")
  Future<Forecast> getForecast();
}
