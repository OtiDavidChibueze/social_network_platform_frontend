import 'package:fpdart/fpdart.dart';
import 'package:social_network_platform/core/error/failure.dart';
import 'package:social_network_platform/core/usecases/use_case.dart';
import 'package:social_network_platform/features/meet/domain/entities/meet_entity.dart';
import 'package:social_network_platform/features/meet/domain/repository/meet_repository.dart';

class GetLastMeetsUsecase
    implements UseCase<Failure, List<MeetEntity>, GetLastMeetParams> {
  final MeetRepository meetRepository;

  GetLastMeetsUsecase({required this.meetRepository});

  @override
  Future<Either<Failure, List<MeetEntity>>> call(
    GetLastMeetParams params,
  ) async {
    return await meetRepository.getLastMeets(
      limit: params.limit,
      page: params.page,
    );
  }
}

class GetLastMeetParams {
  final int page;
  final int limit;

  GetLastMeetParams({required this.page, required this.limit});
}
