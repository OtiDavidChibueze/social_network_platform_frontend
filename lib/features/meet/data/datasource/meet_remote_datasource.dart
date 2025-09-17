import 'package:dio/dio.dart' show Dio;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/server_exception.dart';
import '../../domain/entities/meet_entity.dart';

abstract interface class MeetRemoteDatasource {
  Future<List<MeetEntity>> getLastMeets({int? limit, int? page});

  Future<MeetEntity> createMeet({
    required String title,
    required String description,
    required TimeOfDay time,
    required LatLng location,
  });
}

class MeetRemoteDatasourceImpl implements MeetRemoteDatasource {
  final Dio dio;

  MeetRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<MeetEntity>> getLastMeets({int? limit, int? page}) async {
    try {
      final request = await dio.get(
        'meetings/past',
        queryParameters: {'limit': limit, 'page': page},
      );

      return (request.data as List).map((e) => MeetEntity.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(message: e.toString(), trace: null);
    }
  }

  @override
  Future<MeetEntity> createMeet({
    required String title,
    required String description,
    required TimeOfDay time,
    required LatLng location,
  }) async {
    final request = await dio.post(
      '/meetings/',
      data: {
        'title': title,
        'description': description,
        'date': DateTime.now()
            .copyWith(hour: time.hour, minute: time.minute)
            .toUtc()
            .toIso8601String(),
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
    );

    return MeetEntity.fromJson(request.data);
  }
}
