import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/server_exception.dart';
import '../datasource/meet_remote_datasource.dart';
import '../../domain/entities/meet_entity.dart';
import '../../domain/repository/meet_repository.dart';

class MeetRepositoryImpl implements MeetRepository {
  final MeetRemoteDatasource meetRemoteDatasource;

  MeetRepositoryImpl({required this.meetRemoteDatasource});

  @override
  Future<Either<Failure, List<MeetEntity>>> getLastMeets({
    int? limit,
    int? page,
  }) async {
    try {
      return Right(
        await meetRemoteDatasource.getLastMeets(limit: limit, page: page),
      );
    } on ServerException catch (e) {
      return Left(Failure(message: e.message, trace: e.trace));
    } catch (e) {
      return Left(Failure(message: e.toString(), trace: null));
    }
  }

  @override
  Future<Either<Failure, MeetEntity>> createMeet({
    required String title,
    required String description,
    required TimeOfDay time,
    required LatLng location,
  }) async {
    try {
      return Right(
        await meetRemoteDatasource.createMeet(
          title: title,
          description: description,
          time: time,
          location: location,
        ),
      );
    } on ServerException catch (e) {
      return Left(Failure(message: e.message, trace: e.trace));
    } catch (e) {
      return Left(Failure(message: e.toString(), trace: null));
    }
  }
}
