import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_platform/core/usecases/params.dart';
import 'package:social_network_platform/features/auth/domain/usecases/sign_in_with_google_entity.dart';
import 'package:social_network_platform/features/auth/presentation/bloc/user_event.dart';
import 'package:social_network_platform/features/auth/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;

  UserBloc({required SignInWithGoogleUsecase signInWithGoogleUsecase})
    : _signInWithGoogleUsecase = signInWithGoogleUsecase,
      super(UserState.initial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
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
}
