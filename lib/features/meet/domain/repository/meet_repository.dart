import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/meet_entity.dart';

abstract interface class MeetRepository {
  Future<Either<Failure, List<MeetEntity>>> getLastMeets({
    int? limit,
    int? page,
  });
}
