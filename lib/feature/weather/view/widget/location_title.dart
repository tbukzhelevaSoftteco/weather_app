import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationTitle extends StatelessWidget {
  const LocationTitle({super.key, required Placemark? currentLocationData})
    : _currentLocationData = currentLocationData;

  final Placemark? _currentLocationData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _currentLocationData?.locality != null
              ? '${_currentLocationData!.locality}'
              : '',
          style: TextStyle(fontSize: 32, color: Colors.blueGrey),
        ),
        Text(
          _currentLocationData?.country != null
              ? '${_currentLocationData!.country}'
              : '',
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
      ],
    );
  }
}
