import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failure.dart';
import '../entities/meet_entity.dart';

abstract interface class MeetRepository {
  Future<Either<Failure, List<MeetEntity>>> getLastMeets({
    int? limit,
    int? page,
  });
  Future<Either<Failure, MeetEntity>> createMeet({
    required String title,
    required String description,
    required TimeOfDay time,
    required LatLng location,
  });

  Future<Either<Failure, MeetEntity>> getMeet({required String meetId});
}
