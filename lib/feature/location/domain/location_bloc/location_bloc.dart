import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/location/domain/repository/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;

  LocationBloc(this.repository) : super(LocationIdle()) {
    on<LoadLocation>(_onLoadLocation);
    on<LoadLocationName>(_onLoadLocationName);
  }

  Future<void> _onLoadLocation(
    LoadLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    try {
      final location = await repository.getCurrentLocation();
      emit(LocationLoaded(location));
    } catch (e) {
      emit(LocationError("Failed to fetch location"));
    }
  }

  Future<void> _onLoadLocationName(
    LoadLocationName event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoadingName());
    try {
      final locationData = await repository.getLocationName(event.position);
      emit(LocationLoadName(locationData));
    } catch (e) {
      emit(LocationLoadNameError("Failed to fetch location name"));
    }
  }
}
