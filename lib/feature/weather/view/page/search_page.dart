import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'package:weather_app/feature/location/domain/location_bloc/location_bloc.dart';
import 'package:weather_app/feature/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/feature/weather/domain/bloc/weather_bloc.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Weather? _currentWeather;
  Placemark? _currentLocationData;

  late WeatherBloc _weatherBloc;
  late LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _locationBloc = LocationBloc(LocationRepositoryImpl());
    _weatherBloc = WeatherBloc(WeatherRepositoryImpl());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadWeather();
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
            Text(
              'Search Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
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
