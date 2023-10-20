import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screen/home/weather_api.dart';
import 'package:weather_app/service/api.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherState()) {
    on<GetWeather>(_getWeather);
  }

  void _getWeather(GetWeather event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Api.params['lat'] = position.latitude;
      Api.params['lon'] = position.longitude;
      Forecast forecast = await WeatherApi.getForecast();
      emit(state.copyWith(isLoading: false, forecast: forecast));
    } catch (e) {
      print(e);
    }
  }
}
