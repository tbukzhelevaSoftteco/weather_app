import 'package:auto_route/auto_route.dart';
import 'package:weather_app/feature/location/view/page/geolocation_page.dart';
import 'package:weather_app/feature/weather/view/page/weater_page.dart';

part "router.gr.dart";

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: GeolocationRoute.page, initial: true),
    AutoRoute(page: WeatherRoute.page),
  ];
}
