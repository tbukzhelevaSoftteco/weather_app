import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherByLocation(Position position);
  Future<Weather> getWeatherByCityName(String city);
}
