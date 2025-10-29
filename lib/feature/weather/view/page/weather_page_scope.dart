import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/location/data/repository/location_repository_impl.dart';
import 'package:weather_app/feature/location/domain/location_bloc/location_bloc.dart';
import 'package:weather_app/feature/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/feature/weather/domain/bloc/weather_bloc.dart';
import 'package:weather_app/feature/weather/view/page/weater_page.dart';

@RoutePage()
class WeatherPageScope extends StatelessWidget {
  const WeatherPageScope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(WeatherRepositoryImpl()),
        ),
        BlocProvider(
          create: (_) =>
              LocationBloc(LocationRepositoryImpl())..add(LoadLocation()),
        ),
      ],
      child: WeatherPage(),
    );
  }
}
