import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_picker_event.dart';
import 'location_picker_state.dart';

class LocationPickerBloc
    extends Bloc<LocationPickerEvent, LocationPickerState> {
  LocationPickerBloc() : super(LocationPickerState.initial()) {
    on<GetLocationEvent>(onGetLocationEvent);
    on<SetLocationEvent>(onSetLocationEvent);
  }

  Future<void> onGetLocationEvent(
    GetLocationEvent event,
    Emitter<LocationPickerState> emit,
  ) async {
    emit(state.copyWith(status: LocationPickerStatus.loading));

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    emit(
      state.copyWith(
        status: LocationPickerStatus.success,
        location: LatLng(position.latitude, position.longitude),
      ),
    );
  }

  Future<void> onSetLocationEvent(
    SetLocationEvent event,
    Emitter<LocationPickerState> emit,
  ) async {
    emit(
      state.copyWith(
        location: event.location,
        status: LocationPickerStatus.locationUpdated,
      ),
    );
  }
}
