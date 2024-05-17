import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';

class SignUpUseCase implements UseCase<ResponseModel?, SignUpParams> {
  final FirebaseAuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  @override
  Future<ResponseModel?> call({required SignUpParams params}) {
    return _authRepository.createUserWithEmailAndPassword(params.userName,
        params.email, params.password);
  }
}

class SignUpParams {
  final String userName;
  final String email;
  final String password;

  SignUpParams({required this.userName, required this.email, required this.password});
}
