part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class LoadWeatherByLocation extends WeatherEvent {
  LoadWeatherByLocation();
}

final class LoadWeatherByCityName extends WeatherEvent {
  final String cityName;

  LoadWeatherByCityName(this.cityName);
}
