import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/location/data/model/location_data_impl.dart';
import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'package:weather_app/feature/location/domain/usecase/get_current_location.dart';
import 'package:weather_app/router/router.dart';

@RoutePage()
class GeolocationPage extends StatefulWidget {
  const GeolocationPage({super.key});

  @override
  State<GeolocationPage> createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {
  Position? _currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location App"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Location Coordinates",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              "Latitude = ${_currentLocation?.latitude} ; Longitude = ${_currentLocation?.longitude}",
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                _currentLocation = await fetchLocation();
                setState(() {});
                if (_currentLocation != null) {
                  context.router.push(WeatherRoute());
                }
              },
              child: Text('get location'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position?> fetchLocation() async {
    final currentLocation = await GetCurrentLocation(
      LocationRepositoryImpl(LocationDataSourceImpl()),
    ).call();
    return currentLocation;
  }
}
