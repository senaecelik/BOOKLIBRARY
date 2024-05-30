import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_up_use_case.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  SignUpCubit(this._signUpUseCase) : super(SignUpInitial());

  Future<void> signUp(
      {required String userName,
      required String email,
      required String password}) async {
    emit(SignUpLoading());

    try {
      await _signUpUseCase.call(
          UserEntity(username: userName, email: email, password: password));

      emit(SignUpDone(""));
    } on SocketException catch (_) {
      emit(SignUpError(""));
    } catch (_) {
      emit(SignUpError(""));
    }
  }
}
