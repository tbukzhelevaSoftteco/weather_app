import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

@RoutePage()
class GeolocationPage extends StatefulWidget {
  const GeolocationPage({super.key});

  @override
  State<GeolocationPage> createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();

    if (!servicePermission) {
      print("Service Disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App"), centerTitle: true),

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
              // "${_currentLocation}"
              "Latitude = ${_currentLocation?.latitude} ; Longitude = ${_currentLocation?.longitude}",
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                _currentLocation = await _getCurrentLocation();

                /// Determine the current position of the device.

                ///

                /// When the location services are not enabled or permissions

                /// are denied the `Future` will return an error.
              },
              child: Text('get location'),
            ),
          ],
        ),
      ),
    );
  }
}
