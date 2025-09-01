import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_network_platform/core/error/failure.dart';
import 'package:social_network_platform/core/usecases/use_case.dart';
import 'package:social_network_platform/features/auth/domain/repository/user_repository.dart';

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
