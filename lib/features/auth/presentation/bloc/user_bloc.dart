import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_platform/features/auth/domain/usecases/edit_user_usecase.dart';

import '../../../../core/usecases/params.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/log_out_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
  final GetUserUsecase _getUserUsecase;
  final LogOutUsecase _logOutUsecase;
  final EditUserUsecase _editUserUsecase;

  UserBloc({
    required SignInWithGoogleUsecase signInWithGoogleUsecase,
    required GetUserUsecase getUserUsecase,
    required LogOutUsecase logOutUsecase,
    required EditUserUsecase editUserUsecase,
  }) : _signInWithGoogleUsecase = signInWithGoogleUsecase,
       _getUserUsecase = getUserUsecase,
       _logOutUsecase = logOutUsecase,
       _editUserUsecase = editUserUsecase,
       super(UserState.initial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
    on<GetUserEvent>(_onGetUserEvent);
    on<LogOutEvent>(_onLogOutEvent);
    on<EditUserEvent>(_onEditUserEvent);
  }

  Future<void> _onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));

    final res = await _signInWithGoogleUsecase(NoParams());

    res.fold(
      (l) {
        emit(state.copyWith(status: UserStatus.error, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: UserStatus.success, user: r));
      },
    );
  }

  Future<void> _onGetUserEvent(
    GetUserEvent event,
    Emitter<UserState> emit,
  ) async {
    final result = await _getUserUsecase(NoParams());

    result.fold(
      (l) {
        emit(state.copyWith(status: UserStatus.error, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: UserStatus.success, user: r));
      },
    );
  }

  Future<void> _onLogOutEvent(
    LogOutEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));

    final result = await _logOutUsecase(NoParams());

    result.fold(
      (l) {
        emit(state.copyWith(status: UserStatus.error, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: UserStatus.logout));
      },
    );
  }

  Future<void> _onEditUserEvent(
    EditUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));

    final result = await _editUserUsecase(
      EditUserParams(name: event.name, bio: event.bio, avatar: event.avatar),
    );

    result.fold(
      (l) {
        emit(state.copyWith(status: UserStatus.error, errorMessage: l.message));
      },
      (r) {
        add(GetUserEvent());
      },
    );
  }
}
