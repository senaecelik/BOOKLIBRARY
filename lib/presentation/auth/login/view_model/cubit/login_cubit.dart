import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/repository/authentication/firebase_auth_manger.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(AuthInitial());

  final _repository = FirebaseAuthManager(FirebaseAuth.instance);

  bool isChecked = true;

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await _repository.signInWithEmail(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> signInGoogle() async {
    emit(AuthGoogleLoading());
    try {
      await _repository.signInWithGoogle();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> signInAnonymously() async {
    emit(AuthLoading());

    try {
      await _repository.signInAnonymously();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  bool isVisible() {
    emit(AuthInitial());
    return isChecked = !isChecked;
  }
}
