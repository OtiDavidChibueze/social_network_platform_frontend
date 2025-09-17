import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateMeetEvent extends Equatable {
  final String title;
  final String description;
  final TimeOfDay time;
  final LatLng location;

  const CreateMeetEvent({
    required this.title,
    required this.description,
    required this.time,
    required this.location,
  });

  @override
  List<Object?> get props => [title, description, time, location];
}
