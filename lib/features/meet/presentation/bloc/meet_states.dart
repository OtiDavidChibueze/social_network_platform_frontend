import 'package:equatable/equatable.dart';
import 'package:social_network_platform/features/meet/domain/entities/meet_entity.dart';

enum MeetStatus { initial, loading, success, error }

class MeetStates extends Equatable {
  final MeetStatus status;
  final String? errorMessage;
  final MeetEntity? meet;

  const MeetStates._({required this.status, this.errorMessage, this.meet});

  factory MeetStates.initail() => MeetStates._(status: MeetStatus.initial);

  MeetStates copyWith({
    MeetStatus? status,
    String? errorMessage,
    MeetEntity? meet,
  }) {
    return MeetStates._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      meet: meet ?? this.meet,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, meet];
}
