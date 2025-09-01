import 'dart:io';

import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repository/user_repository.dart';

class EditUserUsecase implements UseCase<Failure, void, EditUserParams> {
  final UserRepository userRepository;

  EditUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(EditUserParams params) async {
    return await userRepository.editUser(
      name: params.name,
      bio: params.bio,
      avatar: params.avatar,
    );
  }
}

class EditUserParams {
  final String name;
  final String bio;
  final File? avatar;

  EditUserParams({required this.name, required this.bio, this.avatar});
}
