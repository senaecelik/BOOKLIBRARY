import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authState;

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();

  Future<void> phoneSignIn(String phoneNumber);

  Future<void> signInWithEmail({
    required String email,
    required String password,
  });

   Future<void> sendPasswordResetEmail({
    required String email,
  });

  Future<void> signInAnonymously();

  Future<void> signOut();

  Future<void> deleteAccount();
}
