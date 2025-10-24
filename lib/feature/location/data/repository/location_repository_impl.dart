import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/location/data/model/location_data_impl.dart';
import 'package:weather_app/feature/location/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSourceImpl dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Position> getCurrentLocation() {
    return dataSource.getCurrentLocation();
  }
}
