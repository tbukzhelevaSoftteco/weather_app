import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/feature/location/data/model/location_data_impl.dart';
import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'package:weather_app/feature/location/domain/usecase/get_current_location.dart';
import 'package:weather_app/feature/weather/data/model/weather_data_impl.dart';
import 'package:weather_app/feature/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/feature/weather/domain/usecase/get_location_name.dart';

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
