import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<void> requestPermissions();
  Future<Position> getCurrentLocation();
  Future<String> getLocationName(Position position);
}
