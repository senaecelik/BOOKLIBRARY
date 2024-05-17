import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_in_use_case.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase _signInUseCase;
  bool isVisible = true;
  SignInCubit(this._signInUseCase) : super(SingInInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoading());

    try {
      // SignInUseCase'ı çağır
      final result = await _signInUseCase(
          params: SignInParams(email: email, password: password));
      // Başarılı olursa Success state'ini yayınla
      if (result != null && result.user != null) {
        emit(SignInDone(result.errorMessage!));
      } else {
        emit(SignInError(result!.errorMessage.toString()));
      }
    } catch (e) {
      // Hata durumunda Error state'ini yayınla
      emit(SignInError(e.toString()));
    }
  }

  void changePasswordObscure() {
    emit(SingInInitial());
    isVisible = !isVisible;
    emit(SingInPasswordObscureChanged());
  }
}
