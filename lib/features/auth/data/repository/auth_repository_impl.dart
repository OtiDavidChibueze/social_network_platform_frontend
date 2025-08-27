import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_network_platform/core/error/failure.dart';
import 'package:social_network_platform/core/error/server_exception.dart';
import 'package:social_network_platform/features/auth/data/dataSources/auth_remote_datasource.dart';
import 'package:social_network_platform/features/auth/domain/entities/user_entity.dart';
import 'package:social_network_platform/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignin = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleSignin?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final firebaseCredentials = await firebaseAuth.signInWithCredential(
        credential,
      );

      final token = await firebaseCredentials.user?.getIdToken();

      if (token != null) {
        return Right(await authRemoteDataSource.signInWithGoogle(token));
      } else {
        return Left(Failure(message: 'Auth Failure', trace: null));
      }
    } on DioException catch (e) {
      return Left(Failure(message: e.response?.data['message'], trace: null));
    } on ServerException catch (e) {
      return Left(Failure(message: e.message, trace: e.trace));
    } catch (e) {
      return Left(Failure(message: e.toString(), trace: null));
    }
  }
}
