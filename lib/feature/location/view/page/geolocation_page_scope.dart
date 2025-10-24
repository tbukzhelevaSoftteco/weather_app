import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'package:weather_app/feature/location/domain/location_bloc/location_bloc.dart';
import 'package:weather_app/feature/location/view/page/geolocation_page.dart';

@RoutePage()
class GeolocationPageScope extends StatelessWidget {
  const GeolocationPageScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          LocationBloc(LocationRepositoryImpl())..add(LoadLocation()),
      child: GeolocationPage(),
    );
  }
}
