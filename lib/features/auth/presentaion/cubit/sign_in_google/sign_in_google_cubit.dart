import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_in_google_use_case.dart';

part 'sign_in_google_state.dart';

class SignInGoogleCubit extends Cubit<SignInGoogleState> {
  final SignInGoogleUsecase _signInGoogleUsecase;
  SignInGoogleCubit(this._signInGoogleUsecase) : super(SignInGoogleInitial());

  Future<void> signInGoogle() async {
    emit(SignInGoogleLoading());
    try {
      await _signInGoogleUsecase();
      emit(SignInGoogleDone());
    } catch (e) {
      emit(SignInGoogleError());
    }
  }
}
