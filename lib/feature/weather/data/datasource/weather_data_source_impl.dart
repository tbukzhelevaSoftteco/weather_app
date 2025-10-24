import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

abstract class WeatherDataSource {
  Future<String> getLocationName(Position position);
}

class WeatherDataSourceImpl implements WeatherDataSource {
  @override
  Future<String> getLocationName(Position position) async {
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      throw Exception('No placemarks found.');
    }

    final place = placemarks.first;
    return '${place.locality}, ${place.country}';
  }
}
