import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final StackTrace? trace;

  const Failure({
    this.message = "Something Went Wrong, Please Try Again",
    required this.trace,
  });

  @override
  List<Object?> get props => [message, trace];
}
