import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';

class SendPasswordResetEmailUseCase implements UseCaseFuture<void, String> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  SendPasswordResetEmailUseCase(this._firebaseAuthRepository);

  @override
  Future<void> call(String email) async {
    return await _firebaseAuthRepository.sendPasswordResetEmail(email);
   
  }
}