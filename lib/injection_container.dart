import 'package:weather_app/features/location/data/repositories/location_repository_impl.dart';
import 'features/location/data/datasources/location_data_source_impl.dart';
import 'features/location/domain/usecases/get_current_location.dart';

GetCurrentLocation initGetCurrentLocationUseCase() {
  final locationDataSource = LocationDataSourceImpl();
  return GetCurrentLocation(LocationRepositoryImpl(locationDataSource));
}
