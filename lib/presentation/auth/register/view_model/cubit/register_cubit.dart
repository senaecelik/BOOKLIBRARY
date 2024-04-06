import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/repository/authentication/firebase_auth_manger.dart';
import 'package:flutter_project/data/responses/validation_model.dart';
import 'package:flutter_project/core/extension/password_validation.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final _repository = FirebaseAuthManager(FirebaseAuth.instance);

  ValidationModel passwordModel = ValidationModel(null, null);

  Future<void> singUp({required String email, required String password}) async {
    try {
      emit(RegisterLoading());
      if (password == passwordModel.value) {
        await _repository.signUpWithEmail(
          email: email,
          password: password,
        );
        emit(RegisterSuccess());
      } else {
        emit(RegisterCheckValid(isValid: false));
      }
    } catch (e) {
      emit(RegisterError(error: e.toString()));
    }
  }

  void validatePassword(String? val) {
    if (val != null && val.isValidPassword) {
      _emitPasswordCheckValid(true);
      passwordModel = ValidationModel(val, null);
    } else if (val == "") {
      _emitPasswordCheckValid(false);
      passwordModel = ValidationModel(null, null);
    } else {
      _emitPasswordCheckValid(false);
      passwordModel = ValidationModel(null,
          "Your password must contain at least one letter, number, and special character and must be at least 6 characters long.");
    }
  }


  void _emitPasswordCheckValid(bool isValid) {
    emit(RegisterCheckValid(isValid: isValid));
  }
}
