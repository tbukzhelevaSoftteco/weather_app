import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';

class GetLocationName {
  final WeatherRepository repository;

  GetLocationName(this.repository);

  Future<String> call(Position position) {
    return repository.getLocationName(position);
  }
}
