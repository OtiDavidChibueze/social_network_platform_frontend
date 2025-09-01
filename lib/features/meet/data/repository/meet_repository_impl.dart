import 'package:fpdart/src/either.dart';
import 'package:social_network_platform/core/error/failure.dart';
import 'package:social_network_platform/core/error/server_exception.dart';
import 'package:social_network_platform/features/meet/data/datasource/meet_remote_datasource.dart';
import 'package:social_network_platform/features/meet/domain/entities/meet_entity.dart';
import 'package:social_network_platform/features/meet/domain/repository/meet_repository.dart';

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
}
