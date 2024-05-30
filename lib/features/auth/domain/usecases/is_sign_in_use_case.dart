
import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';


class IsSignInUseCase implements UseCase<bool, void > {
  final FirebaseAuthRepository repository;

  IsSignInUseCase( this.repository);

  @override
  Future<bool> call([void params]) {
    return repository.isSignIn();
  }
}