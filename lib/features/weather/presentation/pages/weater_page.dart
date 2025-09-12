import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/location/data/datasources/location_data_source_impl.dart';
import 'package:weather_app/features/location/data/repositories/location_repository_impl.dart';
import 'package:weather_app/features/location/domain/usecases/get_current_location.dart';
import 'package:weather_app/features/weather/data/datasources/weather_data_source_impl.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/usecases/get_location_name.dart';

@RoutePage()
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String? _currentLocationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 6),
            Text("Location = $_currentLocationName"),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                _currentLocationName = await fetchLocationName();
                setState(() {});
                print(_currentLocationName);
              },
              child: Text('get location'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> fetchLocationName() async {
    final currentLocation = await GetCurrentLocation(
      LocationRepositoryImpl(LocationDataSourceImpl()),
    ).call();
    final locationName = await GetLocationName(
      WeatherRepositoryImpl(WeatherDataSourceImpl()),
    ).call(currentLocation);
    return locationName;
  }
}
