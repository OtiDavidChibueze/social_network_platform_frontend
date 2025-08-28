import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class SignInWithGoogleUsecase
    implements UseCase<Failure, UserEntity, NoParams> {
  final AuthRepository authRepository;

  SignInWithGoogleUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return authRepository.signInWithGoogle();
  }
}
