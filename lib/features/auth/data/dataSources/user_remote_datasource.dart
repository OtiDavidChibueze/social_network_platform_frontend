import 'dart:io';

import 'package:dio/dio.dart';
import '../../../../core/error/server_exception.dart';
import '../../domain/entities/user_entity.dart';

abstract interface class UserRemoteDatasource {
  Future<UserEntity> getUser();
  Future<void> editUser({required String name, required String bio});
  Future<void> uploadAvatar({required File avatar});
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

  @override
  Future<void> editUser({required String name, required String bio}) async {
    try {
      final request = await dio.put(
        'users/profile',
        data: {'name': name, 'bio': bio},
      );

      return;
    } catch (e) {
      throw ServerException(message: e.toString(), trace: null);
    }
  }

  @override
  Future<void> uploadAvatar({required File avatar}) async {
    try {
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(avatar.path),
      });

      final response = await dio.put('users/avatar', data: formData);

      return;
    } catch (e) {
      throw ServerException(message: e.toString(), trace: null);
    }
  }
}
