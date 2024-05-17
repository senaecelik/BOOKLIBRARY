import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';

class SendPasswordResetEmailUseCase implements UseCase<String?, String> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  SendPasswordResetEmailUseCase(this._firebaseAuthRepository);

  @override
  Future<String?> call({required String params}) async {
    return await _firebaseAuthRepository.sendPasswordResetEmail(params);
   
  }
}