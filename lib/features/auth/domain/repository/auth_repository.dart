import 'package:fpdart/fpdart.dart';

import 'package:social_network_platform/core/error/failure.dart';
import 'package:social_network_platform/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
}
