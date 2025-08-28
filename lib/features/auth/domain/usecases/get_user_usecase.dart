import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/user_entity.dart';
import '../repository/user_repository.dart';

class GetUserUsecase implements UseCase<Failure, UserEntity, NoParams> {
  final UserRepository userRepository;

  GetUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await userRepository.getUser();
  }
}
