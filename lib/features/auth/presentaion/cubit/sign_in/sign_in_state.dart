part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SingInInitial extends SignInState {}
class SingInPasswordObscureChanged extends SignInState {}

class SignInLoading extends SignInState {}
class SignInDone extends SignInState {
  final String message;

  const SignInDone(this.message);

  @override
  List<Object> get props => [message];
}
class SignInError extends SignInState {
  final String errorMessage;

  const SignInError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
