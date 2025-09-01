import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_network_platform/features/auth/domain/entities/user_entity.dart';
part 'meet_entity.g.dart';

@JsonSerializable()
class MeetEntity extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final List<UserEntity> attendees;
  final UserEntity admin;
  final bool isFinished;
  final bool isCancelled;
  final double? latitude;
  final double? lontitude;

  const MeetEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.attendees,
    required this.admin,
    required this.isFinished,
    required this.isCancelled,
    required this.latitude,
    required this.lontitude,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    date,
    attendees,
    admin,
    isFinished,
    isCancelled,
  ];

  factory MeetEntity.fromJson(Map<String, dynamic> json) =>
      _$MeetEntityFromJson(json);
}
