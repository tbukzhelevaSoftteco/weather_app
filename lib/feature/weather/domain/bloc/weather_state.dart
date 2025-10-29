part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherIdle extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded(this.weather);
}

final class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
