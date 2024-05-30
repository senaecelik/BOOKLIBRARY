


import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';

class CreateUserUseCase  implements UseCase<void, UserEntity>{
  final FirebaseAuthRepository repository;

  CreateUserUseCase( this.repository);

  @override
  Future<void> call( UserEntity user) {
    return repository.createUser(user);
  }
}