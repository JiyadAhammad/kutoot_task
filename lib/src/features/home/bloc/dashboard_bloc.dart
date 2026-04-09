import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final Location _locationService = Location();
  DashboardBloc() : super(_DashboardState()) {
    on<_FetchLocationRequested>(_onFetchLocationRequested);
  }

  Future<void> _onFetchLocationRequested(
    _FetchLocationRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isFetchingLocation: true));

    try {
      bool serviceEnabled;
      PermissionStatus permissionGranted;

      serviceEnabled = await _locationService.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _locationService.requestService();
        if (!serviceEnabled) {
          emit(
            state.copyWith(
              isFetchingLocation: false,
              isError: true,
              errorMessage: "Location services are disabled.",
            ),
          );
          return;
        }
      }

      // 2. Check for permissions
      permissionGranted = await _locationService.hasPermission();

      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _locationService.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          emit(
            state.copyWith(
              isFetchingLocation: false,
              isError: true,
              errorMessage: "Location permission denied.",
            ),
          );
          return;
        }
      }

      final locationData = await _locationService.getLocation();
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );
      if (placemarks.isNotEmpty) {
        final geo.Placemark place = placemarks[0];

        final String cityName = place.locality ?? place.name ?? "Unknown";

        emit(
          state.copyWith(isFetchingLocation: false, currentLocation: cityName),
        );
      } else {
        emit(
          state.copyWith(
            isFetchingLocation: false,
            isError: true,
            errorMessage: 'Could not determine address.',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isFetchingLocation: false,
          isError: true,
          errorMessage: "Failed to fetch location: ${e.toString()}",
        ),
      );
    }
  }
}
