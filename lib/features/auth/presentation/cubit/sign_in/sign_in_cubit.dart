import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_in_use_case.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase _signInUseCase;
  bool isVisible = true;

  SignInCubit(this._signInUseCase) : super(SignInInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoading());

    try {
      await _signInUseCase.call(UserEntity(email: email, password: password));
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }

  void changePasswordObscure() {
    isVisible = !isVisible;
    emit(SignInPasswordObscureChanged(isVisible));
  }
}
