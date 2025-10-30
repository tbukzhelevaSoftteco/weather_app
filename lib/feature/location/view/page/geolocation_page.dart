import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'package:weather_app/feature/location/domain/location_bloc/location_bloc.dart';

class GeolocationPage extends StatefulWidget {
  const GeolocationPage({super.key}) : super();

  @override
  State<GeolocationPage> createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {
  Placemark? _currentLocationData;

  late LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _locationBloc = LocationBloc(LocationRepositoryImpl());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLocation();
    });
  }

  Future<void> _loadLocation() async {
    try {
      await _locationBloc.repository.requestPermissions();

      _locationBloc.add(LoadLocation());

      _locationBloc.stream.listen((state) {
        if (state is LocationLoaded) {
          _loadLocationName(state.location!);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(_currentLocationData?.locality ?? ""),
          Text(_currentLocationData?.country ?? ""),
        ],
      ),
    );
  }
}
