import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, void>> logOut();
}
