import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/location/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    final authorized =
        permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;

    if (!authorized) throw Exception("Permission not granted");
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Future<Placemark> getLocationName(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks[0];

    return place;
  }

  @override
  Future<void> requestPermissions() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }
  }
}
