import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_network_platform/core/error/failure.dart';
import 'package:social_network_platform/core/usecases/use_case.dart';
import 'package:social_network_platform/features/meet/domain/entities/meet_entity.dart';
import 'package:social_network_platform/features/meet/domain/repository/meet_repository.dart';

class CreateMeetUsecase
    implements UseCase<Failure, MeetEntity, CreateMeetParams> {
  final MeetRepository meetRepository;

  CreateMeetUsecase({required this.meetRepository});

  @override
  Future<Either<Failure, MeetEntity>> call(CreateMeetParams params) async {
    return await meetRepository.createMeet(
      title: params.title,
      description: params.description,
      time: params.time,
      location: params.location,
    );
  }
}

class CreateMeetParams extends Equatable {
  final String title;
  final String description;
  final TimeOfDay time;
  final LatLng location;
  const CreateMeetParams({
    required this.title,
    required this.description,
    required this.time,
    required this.location,
  });
  @override
  List<Object?> get props => [title, description, time, location];
}
