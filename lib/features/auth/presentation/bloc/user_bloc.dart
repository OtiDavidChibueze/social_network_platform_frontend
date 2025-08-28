import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/params.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
  final GetUserUsecase _getUserUsecase;

  UserBloc({
    required SignInWithGoogleUsecase signInWithGoogleUsecase,
    required GetUserUsecase getUserUsecase,
  }) : _signInWithGoogleUsecase = signInWithGoogleUsecase,
       _getUserUsecase = getUserUsecase,
       super(UserState.initial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
    on<GetUserEvent>(_onGetUserEvent);
  }

  Future<void> _onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<UserState> emit,
  ) async {
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
        state.copyWith(status: UserStatus.error, errorMessage: l.message);
      },
      (r) {
        emit(state.copyWith(status: UserStatus.success, user: r));
      },
    );
  }
}
