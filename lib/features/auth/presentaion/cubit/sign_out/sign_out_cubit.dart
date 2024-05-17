import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_out_use_case.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase _signOutUseCase;
  SignOutCubit(this._signOutUseCase) : super(SignOutInitial());

  void signOut() {
    try {
       _signOutUseCase();
      emit(SignOutDone());
    } catch (e) {
      emit(SignOutError(e.toString()));
    }
  }
}