import 'package:dio/dio.dart';
import '../../../../core/error/server_exception.dart';
import '../../domain/entities/user_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserEntity> signInWithGoogle(String token);
}

class AuthRepositorySourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRepositorySourceImpl({required this.dio});

  @override
  Future<UserEntity> signInWithGoogle(String token) async {
    try {
      final request = await dio.post('users/auth', data: {"token": token});

      return UserEntity.fromJson(request.data);
    } catch (e) {
      throw ServerException(message: e.toString(), trace: null);
    }
  }
}
