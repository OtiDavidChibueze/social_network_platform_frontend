import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_network_platform/features/auth/data/repository/auth_repository_impl.dart';
import 'package:social_network_platform/features/auth/data/sources/auth_remote_datasource.dart';
import 'package:social_network_platform/features/auth/domain/repository/auth_repository.dart';
import 'package:social_network_platform/features/auth/domain/usecases/sign_in_with_google_entity.dart';
import 'package:social_network_platform/features/auth/presentation/bloc/user_bloc.dart';

GetIt getIt = GetIt.I;

void setLocator() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => GoogleSignIn());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  _setAuth();
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
    ..registerLazySingleton(() => UserBloc(signInWithGoogleUsecase: getIt()));
}
