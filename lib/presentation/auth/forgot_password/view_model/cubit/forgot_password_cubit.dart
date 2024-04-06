import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/repository/authentication/firebase_auth_manger.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  final _repository = FirebaseAuthManager(FirebaseAuth.instance);

  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(ForgotPasswordLoading());
    await _repository.sendPasswordResetEmail(email: email).then((value) {
      emit(ForgotPasswordSuccess());
    }).catchError((error, stackTrace) {
      emit(ForgotPasswordError(error: error.toString()));
    });
  }
}
