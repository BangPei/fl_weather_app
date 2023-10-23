// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/common/session_manager.dart';
import 'package:weather_app/dio_injector/navigation_service.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/user_model.dart';
import 'package:weather_app/screen/weather/weather_api.dart';
import 'package:weather_app/service/api.dart';
import 'package:weather_app/service/auth_firebase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

final NavigationService _nav = locator<NavigationService>();

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherState()) {
    on<GetWeather>(_getWeather);
    on<OnSignOut>(_onSignOut);
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
      Api.params['units'] = "metric"; // get data in Celcius
      Forecast forecast = await WeatherApi.getForecast();
      var json = await Session.get("user");
      UserModel user = UserModel.fromJson(jsonDecode(json ?? ""));
      emit(state.copyWith(isLoading: false, forecast: forecast, user: user));
    } catch (e) {
      print(e);
    }
  }

  _onSignOut(OnSignOut event, Emitter<WeatherState> emit) async {
    await AuthFirebase.signOut();
    await Session.clear();
    // ignore: use_build_context_synchronously
    _nav.navKey.currentContext!.pushReplacement("/auth");
  }
}
