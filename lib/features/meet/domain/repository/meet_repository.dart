import 'package:fpdart/fpdart.dart';
import 'package:social_network_platform/core/error/failure.dart';
import 'package:social_network_platform/features/meet/domain/entities/meet_entity.dart';

abstract interface class MeetRepository {
  Future<Either<Failure, List<MeetEntity>>> getLastMeets({
    int? limit,
    int? page,
  });
}
