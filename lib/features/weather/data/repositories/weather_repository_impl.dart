import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/weather/data/datasources/weather_data_source_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSource dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<String> getLocationName(Position position) {
    return dataSource.getLocationName(position);
  }
}
