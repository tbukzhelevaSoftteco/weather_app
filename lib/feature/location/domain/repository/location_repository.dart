import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<void> requestPermissions();
  Future<Position> getCurrentLocation();
  Future<Placemark> getLocationName(Position position);
}
