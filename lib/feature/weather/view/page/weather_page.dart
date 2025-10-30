import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'package:weather_app/feature/location/domain/location_bloc/location_bloc.dart';
import 'package:weather_app/feature/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/feature/weather/domain/bloc/weather_bloc.dart';
import 'package:weather_app/feature/weather/view/widget/location_title.dart';
import 'package:weather_app/feature/weather/view/widget/weather_description.dart';
import 'package:weather_app/feature/weather/view/widget/weather_conditions.dart';

@RoutePage()
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _currentWeather;
  Position? _currentLocation;
  Placemark? _currentLocationData;

  late WeatherBloc _weatherBloc;
  late LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _locationBloc = LocationBloc(LocationRepositoryImpl());
    _weatherBloc = WeatherBloc(WeatherRepositoryImpl());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLocation();
      _loadWeather();
    });
  }

  Future<void> _loadLocation() async {
    try {
      await _locationBloc.repository.requestPermissions();
      _locationBloc.add(LoadLocation());
      _locationBloc.stream.listen((state) {
        if (state is LocationLoaded) {
          setState(() {
            _currentLocation = state.location as Position;
          });
          _loadLocationName(_currentLocation!);
        } else if (state is LocationError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _loadLocationName(Position position) async {
    _locationBloc.add(LoadLocationName(position));
    _locationBloc.stream.listen((state) {
      if (state is LocationLoadName) {
        setState(() {
          _currentLocationData = state.locationData;
        });
      } else if (state is LocationLoadNameError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.message)));
      }
    });
  }

  Future<void> _loadWeather() async {
    _weatherBloc.add(LoadWeatherByLocation());
    try {
      await _weatherBloc.stream.listen((state) {
        print('Weather State: $state');
        if (state is WeatherLoadedByLocation) {
          setState(() {
            _currentWeather = state.weatherByLocation;
          });
        }
      }).asFuture();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LocationTitle(currentLocationData: _currentLocationData),
            _currentWeather != null
                ? WeatherDescription(currentWeather: _currentWeather)
                : SizedBox.shrink(),
            SizedBox(height: 40),
            _currentWeather != null
                ? WeatherConditions(currentWeather: _currentWeather)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weatherBloc.close();
    _locationBloc.close();
    super.dispose();
  }
}
