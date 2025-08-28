import 'package:dio/dio.dart';
import '../../../../core/error/server_exception.dart';
import '../../domain/entities/user_entity.dart';

abstract interface class UserRemoteDatasource {
  Future<UserEntity> getUser();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final Dio dio;

  UserRemoteDatasourceImpl({required this.dio});

  @override
  Future<UserEntity> getUser() async {
    try {
      final request = await dio.get('users/profile');

      return UserEntity.fromJson(request.data);
    } catch (e) {
      throw ServerException(message: e.toString(), trace: null);
    }
  }
}
