import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/common/l10n/generated/l10n.dart';
import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'package:weather_app/feature/location/domain/location_bloc/location_bloc.dart';
import 'package:weather_app/router/router.dart';

class GeolocationPage extends StatefulWidget {
  const GeolocationPage({super.key}) : super();

  @override
  State<GeolocationPage> createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {
  Position? _currentLocation;
  String? _currentLocationName;

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location Name: ${state.location}')),
          );
          setState(() {
            _currentLocation = state.location as Position;
          });
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location Name: ${state.locationName}')),
        );
        setState(() {
          _currentLocationName = state.locationName as String?;
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
      appBar: AppBar(
        title: Text(S.of(context).weather_app_title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).location_coordinates,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              _currentLocation != null
                  ? "Latitude = ${_currentLocation!.latitude} ; Longitude = ${_currentLocation!.longitude}"
                  : "",
            ),
            const SizedBox(height: 30.0),
            Text(
              _currentLocationName != null
                  ? "Location Name: ${_currentLocationName!}"
                  : "",
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                context.router.push(WeatherRoute());
              },
              child: Text(S.of(context).get_location),
            ),
          ],
        ),
      ),
    );
  }
}
