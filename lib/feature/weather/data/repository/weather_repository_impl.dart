import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/weather/data/model/weather_data_impl.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSource dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<String> getLocationName(Position position) {
    return dataSource.getLocationName(position);
  }
}
