import 'package:auto_route/auto_route.dart';
import 'package:weather_app/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: GeolocationRoute.page, initial: true),

    /// routes go here
  ];
}
