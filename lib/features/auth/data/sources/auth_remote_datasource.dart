import 'package:dio/dio.dart';
import 'package:social_network_platform/core/error/server_exception.dart';
import 'package:social_network_platform/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserEntity> signInWithGoogle(String token);
}

class AuthRepositorySourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRepositorySourceImpl({required this.dio});

  @override
  Future<UserEntity> signInWithGoogle(String token) async {
    try {
      final response = await dio.post('users/auth', data: {"token": token});

      print(response);

      return UserEntity.fromJson(response.data);
    } catch (e) {
      throw ServerException(message: e.toString(), trace: null);
    }
  }
}
