import 'package:dio/dio.dart' show Dio;
import '../../../../core/error/server_exception.dart';
import '../../domain/entities/meet_entity.dart';

abstract interface class MeetRemoteDatasource {
  Future<List<MeetEntity>> getLastMeets({int? limit, int? page});
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
}
