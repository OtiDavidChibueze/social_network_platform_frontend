import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_network_platform/core/error/failure.dart';
import 'package:social_network_platform/core/usecases/use_case.dart';
import 'package:social_network_platform/features/meet/domain/entities/meet_entity.dart';
import 'package:social_network_platform/features/meet/domain/repository/meet_repository.dart';

class GetMeetUsecase implements UseCase<Failure, MeetEntity, GetMeetParams> {
  final MeetRepository meetRepository;

  GetMeetUsecase({required this.meetRepository});

  @override
  Future<Either<Failure, MeetEntity>> call(GetMeetParams params) async {
    return await meetRepository.getMeet(meetId: params.meetId);
  }
}

class GetMeetParams extends Equatable {
  final String meetId;

  const GetMeetParams({required this.meetId});

  @override
  List<Object?> get props => [meetId];
}
