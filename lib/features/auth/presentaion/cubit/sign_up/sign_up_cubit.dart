import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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
      final result = await _signUpUseCase(
          params: SignUpParams(
              userName: userName, email: email, password: password));
      // Başarılı olursa Success state'ini yayınla
      if (result != null && result.user != null) {
        emit(SignUpDone(result.errorMessage!));
      } else {
        emit(SignUpError(result!.errorMessage.toString()));
      }
    } catch (e) {
      // Hata durumunda Error state'ini yayınla
      emit(SignUpError(e.toString()));
    }
  }
}
