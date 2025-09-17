import 'package:equatable/equatable.dart';
import 'package:social_network_platform/features/meet/domain/entities/meet_entity.dart';

enum CreateMeetStatus { initial, loading, success, error }

class CreateMeetState extends Equatable {
  final CreateMeetStatus status;
  final String? errorMessage;
  final MeetEntity? createdMeet;

  const CreateMeetState._({
    required this.status,
    this.errorMessage,
    this.createdMeet,
  });

  factory CreateMeetState.initial() =>
      CreateMeetState._(status: CreateMeetStatus.initial);

  @override
  List<Object?> get props => [status, errorMessage, createdMeet];

  CreateMeetState copyWith({
    CreateMeetStatus? status,
    String? errorMessage,
    MeetEntity? createdMeet,
  }) {
    return CreateMeetState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      createdMeet: createdMeet ?? this.createdMeet,
    );
  }
}
