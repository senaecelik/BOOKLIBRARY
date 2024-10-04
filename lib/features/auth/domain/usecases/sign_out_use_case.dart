import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';

class SignOutUseCase implements UseCaseFuture<void, void> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  SignOutUseCase(this._firebaseAuthRepository);

  @override
  Future<void> call([void params]) async {
    return await _firebaseAuthRepository.signOut();
   
  }
}