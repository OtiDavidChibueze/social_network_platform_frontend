import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

/*************  ✨ Windsurf Command ⭐  *************/
/// Register singleton dependencies for the whole app.
///
/// This function should be called in the main function before running the app.
///
/// It registers Dio with token interceptor enabled, GoogleSignIn and FirebaseAuth.
/// *****  ec29f530-0dc7-4bec-a3dc-0770ff70795e  ******
void setLocator() {
  getIt.registerLazySingleton<Dio>(
    () => ApiClient().getDio(tokenInterceptor: true),
  );

  getIt.registerLazySingleton(() => GoogleSignIn());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  _setAuth();

  _setUser();
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
      () => UserBloc(signInWithGoogleUsecase: getIt(), getUserUsecase: getIt()),
    );
}

_setUser() {
  getIt
    ..registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(dio: getIt()),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSource: getIt()),
    )
    ..registerFactory(() => GetUserUsecase(userRepository: getIt()));
}
