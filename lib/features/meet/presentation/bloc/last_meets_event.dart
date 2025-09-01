import 'package:equatable/equatable.dart';

class LastMeetsEvent extends Equatable {
  const LastMeetsEvent();

  @override
  List<Object?> get props => [];
}

class GetLastMeetsEvent extends LastMeetsEvent {
  final bool refresh;

  const GetLastMeetsEvent({this.refresh = false});
}
