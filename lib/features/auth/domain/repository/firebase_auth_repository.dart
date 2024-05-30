import 'package:flutter_project/features/auth/domain/entity/user_entity.dart';

abstract class FirebaseAuthRepository {
  Future<void> signInWithEmailAndPassword(UserEntity user);
  Future<void> createUserWithEmailAndPassword(UserEntity user);
  Future<void> sendPasswordResetEmail(String email);
  Future<bool> isSignIn();
  Future<void> signOut();

  Future<void> createUser(UserEntity user);
  Future<String> getCurrentUid();
}
