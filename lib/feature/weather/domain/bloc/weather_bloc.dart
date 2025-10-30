import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherIdle()) {
    on<LoadWeatherByLocation>(_onLoadWeatherByLocation);
    on<LoadWeatherByCityName>(_onLoadWeatherByCityName);
  }

  Future<void> _onLoadWeatherByLocation(
    LoadWeatherByLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final position = await Geolocator.getCurrentPosition();
      print("Current Position!!!!!: $position");
      final weather = await repository.getWeatherByLocation(position);
      print("Fetched Weather: $weather");
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> _onLoadWeatherByCityName(
    LoadWeatherByCityName event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await repository.getWeatherByCityName(event.cityName);
      print("Fetched Weather: $weather");
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
