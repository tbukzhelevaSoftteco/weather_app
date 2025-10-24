import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/feature/location/domain/repository/location_repository.dart';

part 'location_permission_event.dart';
part 'location_permission_state.dart';

class LocationPermissionBloc
    extends Bloc<LocationPermissionEvent, LocationPermissionState> {
  final LocationRepository repository;

  LocationPermissionBloc(this.repository) : super(LocationPermissionIdle()) {
    on<LocationPermissionEvent>(_onLocationPermissions);
  }

  FutureOr<void> _onLocationPermissions(
    LocationPermissionEvent event,
    Emitter<LocationPermissionState> emit,
  ) async {
    try {
      await repository.requestPermissions();
    } catch (e) {
      print(e);
    } finally {
      emit(LocationPermissionRequestcompleted());
    }
  }
}
