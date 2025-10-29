part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationIdle extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationLoadingName extends LocationState {}

final class LocationLoaded extends LocationState {
  final dynamic location; // Replace dynamic with actual location type

  LocationLoaded(this.location);
}

final class LocationLoadName extends LocationState {
  final String locationName;

  LocationLoadName(this.locationName);
}

final class LocationLoadNameError extends LocationState {
  final String message;

  LocationLoadNameError(this.message);
}

final class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
