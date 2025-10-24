import 'package:geolocator/geolocator.dart';

abstract class WeatherRepository {
  Future<String> getLocationName(Position position);
}
