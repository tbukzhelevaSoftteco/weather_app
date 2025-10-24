import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/location/data/datasource/location_data_source_impl.dart';
import 'package:weather_app/feature/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Position> getCurrentLocation() {
    return dataSource.getCurrentLocation();
  }
}
