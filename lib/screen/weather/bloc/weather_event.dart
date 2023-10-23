part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object?> get props => [];
}

class GetWeather extends WeatherEvent {
  const GetWeather();
}

class OnSignOut extends WeatherEvent {
  const OnSignOut();
}
