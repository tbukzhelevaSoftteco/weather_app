part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

final class LoadLocation extends LocationEvent {}

final class LoadLocationName extends LocationEvent {
  final Position position;

  LoadLocationName(this.position);
}
