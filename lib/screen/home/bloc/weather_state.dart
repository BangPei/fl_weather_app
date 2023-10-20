part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final Forecast? forecast;
  final bool? isLoading;
  const WeatherState({this.forecast, this.isLoading});

  WeatherState copyWith({Forecast? forecast, bool? isLoading}) {
    return WeatherState(
        forecast: this.forecast ?? forecast,
        isLoading: this.isLoading ?? isLoading);
  }

  @override
  List<Object?> get props => [forecast, isLoading];
}
