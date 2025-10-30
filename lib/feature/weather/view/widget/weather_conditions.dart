import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherConditions extends StatelessWidget {
  const WeatherConditions({super.key, required Weather? currentWeather})
    : _currentWeather = currentWeather;

  final Weather? _currentWeather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Icon(Icons.air, color: Colors.lightBlue, size: 28),
            Text(
              _currentWeather?.windSpeed != null
                  ? ' ${_currentWeather!.windSpeed!.toStringAsFixed(1)} m/s'
                  : '',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.water_drop, color: Colors.blue, size: 28),
            Text(
              _currentWeather?.humidity != null
                  ? ' ${_currentWeather!.humidity!.toStringAsFixed(0)} %'
                  : '',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.compress, color: Colors.grey, size: 28),
            Text(
              _currentWeather?.pressure != null
                  ? ' ${_currentWeather!.pressure!.toStringAsFixed(0)} hPa'
                  : '',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ],
        ),
      ],
    );
  }
}
