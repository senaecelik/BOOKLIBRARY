part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}
final class ForgotPasswordLoading extends ForgotPasswordState {}
final class ForgotPasswordDone extends ForgotPasswordState {
  final String message;

  const ForgotPasswordDone(this.message);
  @override
  List<Object> get props => [message];

}
final class ForgotPasswordError extends ForgotPasswordState {
  final String errorMessage;

  const ForgotPasswordError(this.errorMessage);
    @override
  List<Object> get props => [errorMessage];
}

