import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum LocationPickerStatus { initial, loading, success, error }

class LocationPickerState extends Equatable {
  final LocationPickerStatus status;
  final LatLng? location;
  final String? errorMessage;

  const LocationPickerState._({
    required this.status,
    this.location,
    this.errorMessage,
  });

  factory LocationPickerState.initial() =>
      LocationPickerState._(status: LocationPickerStatus.initial);

  @override
  List<Object?> get props => [status, location, errorMessage];

  LocationPickerState copyWith({
    LocationPickerStatus? status,
    LatLng? location,
    String? errorMessage,
  }) {
    return LocationPickerState._(
      status: status ?? this.status,
      location: location ?? this.location,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
