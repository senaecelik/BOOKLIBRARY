
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project/features/auth/domain/usecases/send_password_reset_email_use_case.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final SendPasswordResetEmailUseCase _sendPasswordResetEmailUseCase;

  ForgotPasswordCubit(this._sendPasswordResetEmailUseCase)
      : super(ForgotPasswordInitial());

  Future<void> sendPasswordResetEmail({required String email}) async{
    emit(ForgotPasswordLoading());
    try {
      final result = await _sendPasswordResetEmailUseCase(params: email);
      
            emit(ForgotPasswordDone(result.toString()));
    } catch (e) {
      emit(ForgotPasswordDone(e.toString()));
    }
  }
}
