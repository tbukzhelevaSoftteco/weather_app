import 'package:geolocator/geolocator.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Position> getCurrentLocation() {
    return dataSource.getCurrentLocation();
  }
}
