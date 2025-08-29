import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/use_case.dart';
import '../repository/user_repository.dart';

class LogOutUsecase implements UseCase<Failure, void, NoParams> {
  final UserRepository userRepository;

  LogOutUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await userRepository.logOut();
  }
}
