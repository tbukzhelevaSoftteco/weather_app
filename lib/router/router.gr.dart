part of 'router.dart';

class GeolocationRoute extends PageRouteInfo<void> {
  const GeolocationRoute({List<PageRouteInfo>? children})
    : super(GeolocationRoute.name, initialChildren: children);

  static const String name = 'GeolocationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GeolocationPage();
    },
  );
}

class WeatherRoute extends PageRouteInfo<void> {
  const WeatherRoute({List<PageRouteInfo>? children})
    : super(WeatherRoute.name, initialChildren: children);

  static const String name = 'WeatherRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WeatherPage();
    },
  );
}
