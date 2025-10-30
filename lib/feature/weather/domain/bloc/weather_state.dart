part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherIdle extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoadedByLocation extends WeatherState {
  final Weather weatherByLocation;
  WeatherLoadedByLocation(this.weatherByLocation);
}

final class WeatherLoadedByCityName extends WeatherState {
  final Weather weatherByCityName;

  WeatherLoadedByCityName(this.weatherByCityName);
}

final class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
