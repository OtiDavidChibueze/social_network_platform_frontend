import 'package:fpdart/fpdart.dart';
import 'package:social_network_platform/core/error/failure.dart';
import 'package:social_network_platform/core/usecases/params.dart';
import 'package:social_network_platform/core/usecases/use_case.dart';
import 'package:social_network_platform/features/auth/domain/entities/user_entity.dart';
import 'package:social_network_platform/features/auth/domain/repository/auth_repository.dart';

class SignInWithGoogleUsecase
    implements UseCase<Failure, UserEntity, NoParams> {
  final AuthRepository authRepository;

  SignInWithGoogleUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return authRepository.signInWithGoogle();
  }
}
