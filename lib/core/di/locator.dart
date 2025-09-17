import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/create_meet/create_meet_bloc.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/location_picker/location_picker_bloc.dart';
import 'package:social_network_platform/features/meet/domain/usecases/create_meet_usecase.dart';
import '../../features/auth/domain/usecases/edit_user_usecase.dart';
import '../../features/meet/data/datasource/meet_remote_datasource.dart';
import '../../features/meet/data/repository/meet_repository_impl.dart';
import '../../features/meet/domain/repository/meet_repository.dart';
import '../../features/meet/domain/usecases/get_last_meet_usecase.dart';
import '../../features/meet/presentation/bloc/last_meets_bloc.dart';
import '../../features/auth/domain/usecases/log_out_usecase.dart';
import '../api/api_client.dart';
import '../../features/auth/data/dataSources/user_remote_datasource.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/data/dataSources/auth_remote_datasource.dart';
import '../../features/auth/data/repository/user_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/repository/user_repository.dart';
import '../../features/auth/domain/usecases/get_user_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import '../../features/auth/presentation/bloc/user_bloc.dart';

GetIt getIt = GetIt.I;

void setLocator() {
  getIt.registerLazySingleton<Dio>(
    () => ApiClient().getDio(tokenInterceptor: true),
  );

  getIt.registerLazySingleton(() => GoogleSignIn());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  _setAuth();

  _setUser();

  _setMeet();

  getIt.registerFactory(() => LocationPickerBloc());
}

_setAuth() {
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRepositorySourceImpl(dio: getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: getIt(),
        googleSignIn: getIt(),
        firebaseAuth: getIt(),
      ),
    )
    ..registerFactory(() => SignInWithGoogleUsecase(authRepository: getIt()))
    ..registerLazySingleton(
      () => UserBloc(
        signInWithGoogleUsecase: getIt(),
        getUserUsecase: getIt(),
        logOutUsecase: getIt(),
        editUserUsecase: getIt(),
      ),
    );
}

_setUser() {
  getIt
    ..registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(dio: getIt()),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userRemoteDataSource: getIt(),
        firebaseAuth: getIt(),
      ),
    )
    ..registerFactory(() => GetUserUsecase(userRepository: getIt()))
    ..registerFactory(() => LogOutUsecase(userRepository: getIt()))
    ..registerFactory(() => EditUserUsecase(userRepository: getIt()));
}

_setMeet() {
  getIt
    ..registerLazySingleton<MeetRemoteDatasource>(
      () => MeetRemoteDatasourceImpl(dio: getIt()),
    )
    ..registerLazySingleton<MeetRepository>(
      () => MeetRepositoryImpl(meetRemoteDatasource: getIt()),
    )
    ..registerFactory(() => GetLastMeetsUsecase(meetRepository: getIt()))
    ..registerFactory(() => CreateMeetUsecase(meetRepository: getIt()))
    ..registerLazySingleton(() => LastMeetsBloc(getLastMeetsUsecase: getIt()))
    ..registerLazySingleton(() => CreateMeetBloc(createMeetUsecase: getIt()));
}
