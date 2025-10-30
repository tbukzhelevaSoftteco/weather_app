import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<Weather> getWeatherByLocation(Position position) async {
    final weather = WeatherFactory(dotenv.env['WEATHER_API_KEY']!);
    return await weather.currentWeatherByLocation(
      position.latitude,
      position.longitude,
    );
  }

  @override
  Future<Weather> getWeatherByCityName(String cityName) async {
    final weather = WeatherFactory(dotenv.env['WEATHER_API_KEY']!);
    return await weather.currentWeatherByCityName(cityName);
  }
}
