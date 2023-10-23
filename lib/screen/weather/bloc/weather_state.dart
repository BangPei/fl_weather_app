part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final Forecast? forecast;
  final bool? isLoading;
  final UserModel? user;
  const WeatherState({this.forecast, this.isLoading = true, this.user});

  WeatherState copyWith(
      {Forecast? forecast, bool? isLoading, UserModel? user}) {
    return WeatherState(
      forecast: forecast ?? this.forecast,
      isLoading: isLoading ?? this.isLoading ?? true,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [forecast, isLoading, user];
}
