import 'package:flutter_project/features/auth/data/data_source/remote/auth_data_source.dart';

abstract class FirebaseAuthRepository {
  Future<ResponseModel?> signInWithEmailAndPassword( String email, String password);
  Future<ResponseModel?> createUserWithEmailAndPassword(String userName,String email, String password);
  Future<String?> sendPasswordResetEmail(String email);
  Future<ResponseModel?> signInWithGoogle();
  Future<void> signOut();
}
