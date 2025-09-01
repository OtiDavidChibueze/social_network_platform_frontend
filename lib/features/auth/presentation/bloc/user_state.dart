import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

enum UserStatus {
  initial,
  loading,
  success,
  error,
  logout,
  successFullyEditedProfile,
}

class UserState extends Equatable {
  final UserStatus status;
  final String? errorMessage;
  final UserEntity? user;

  const UserState._({required this.status, this.errorMessage, this.user});

  factory UserState.initial() => UserState._(status: UserStatus.initial);

  UserState copyWith({
    UserStatus? status,
    String? errorMessage,
    UserEntity? user,
  }) {
    return UserState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user];
}
