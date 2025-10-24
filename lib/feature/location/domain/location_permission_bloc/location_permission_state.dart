part of 'location_permission_bloc.dart';

@immutable
sealed class LocationPermissionState {}

final class LocationPermissionIdle extends LocationPermissionState {}

final class LocationPermissionRequestcompleted
    extends LocationPermissionState {}
