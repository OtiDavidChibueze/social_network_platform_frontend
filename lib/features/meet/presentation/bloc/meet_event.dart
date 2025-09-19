import 'package:equatable/equatable.dart';

class GetMeetEvent extends Equatable {
  final String meetId;

  const GetMeetEvent({required this.meetId});

  @override
  List<Object?> get props => [meetId];
}
