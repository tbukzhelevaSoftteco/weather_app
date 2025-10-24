import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/location/domain/repository/location_repository.dart';

class GetCurrentLocation {
  final LocationRepository repository;

  GetCurrentLocation(this.repository);

  Future<Position> call() {
    return repository.getCurrentLocation();
  }
}
