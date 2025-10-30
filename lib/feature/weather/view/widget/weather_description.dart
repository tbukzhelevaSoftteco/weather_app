import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherDescription extends StatelessWidget {
  const WeatherDescription({super.key, required Weather? currentWeather})
    : _currentWeather = currentWeather;

  final Weather? _currentWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: NetworkImage(
            'http://openweathermap.org/img/wn/${_currentWeather?.weatherIcon}@4x.png',
          ),
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_currentWeather?.temperature?.celsius?.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              '°C',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        Text(
          _currentWeather?.weatherDescription != null
              ? '${_currentWeather!.weatherDescription![0].toUpperCase()}${_currentWeather!.weatherDescription!.substring(1).toLowerCase()}'
              : '',
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
        Text(
          _currentWeather?.tempFeelsLike != null
              ? 'Feels Like: ${_currentWeather!.tempFeelsLike!.celsius!.toStringAsFixed(1)} °C '
              : '',
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
        Text(
          _currentWeather?.tempMin != null && _currentWeather?.tempMax != null
              ? 'Min: ${_currentWeather!.tempMin!.celsius!.toStringAsFixed(1)} °C / Max: ${_currentWeather!.tempMax!.celsius!.toStringAsFixed(1)} °C'
              : '',
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
      ],
    );
  }
}
