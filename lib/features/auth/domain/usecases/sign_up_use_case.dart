import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';

class SignUpUseCase implements UseCase<void, UserEntity> {
  final FirebaseAuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  @override
  Future<void> call(UserEntity user) {
    return _authRepository.createUserWithEmailAndPassword(user);
  }
}
