import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';

class SignInUseCase implements UseCase<ResponseModel?, SignInParams> {
  final FirebaseAuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  @override
  Future<ResponseModel?> call({required SignInParams params}) {
    return _authRepository.signInWithEmailAndPassword(
        params.email, params.password);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
