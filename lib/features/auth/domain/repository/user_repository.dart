import 'dart:io';

import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, void>> logOut();
  // Future<Either<Failure, void>> editUser({
  //   required String name,
  //   required String bio,
  //   File? avatar,
  // });
}
