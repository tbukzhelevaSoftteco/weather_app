import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'feature/location/data/model/location_data_impl.dart';
import 'feature/location/domain/usecase/get_current_location.dart';

GetCurrentLocation initGetCurrentLocationUseCase() {
  final locationDataSource = LocationDataSourceImpl();
  return GetCurrentLocation(LocationRepositoryImpl(locationDataSource));
}
