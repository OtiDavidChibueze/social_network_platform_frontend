import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationPickerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLocationEvent extends LocationPickerEvent {
  @override
  List<Object?> get props => [];
}

class SetLocationEvent extends LocationPickerEvent {
  final LatLng location;

  SetLocationEvent({required this.location});

  @override
  List<Object?> get props => [location];
}
