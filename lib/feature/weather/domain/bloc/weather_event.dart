part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class LoadWeather extends WeatherEvent {
  LoadWeather();
}
