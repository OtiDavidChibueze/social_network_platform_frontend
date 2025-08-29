import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/server_exception.dart';
import '../dataSources/user_remote_datasource.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDataSource;
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      return (Right(await userRemoteDataSource.getUser()));
    } on DioException catch (e) {
      return (Left(Failure(message: e.response?.data['message'], trace: null)));
    } on ServerException catch (e) {
      return (Left(Failure(message: e.message, trace: e.trace)));
    } catch (e) {
      return (Left(Failure(message: e.toString(), trace: null)));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await _firebaseAuth.signOut();

      return Right(null);
    } on DioException catch (e) {
      return (Left(Failure(message: e.response?.data['message'], trace: null)));
    } on ServerException catch (e) {
      return (Left(Failure(message: e.toString(), trace: null)));
    }
  }
}
