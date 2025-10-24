import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'feature/location/data/datasource/location_data_source_impl.dart';
import 'feature/location/domain/usecases/get_current_location.dart';

GetCurrentLocation initGetCurrentLocationUseCase() {
  final locationDataSource = LocationDataSourceImpl();
  return GetCurrentLocation(LocationRepositoryImpl(locationDataSource));
}
