part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {
  final String message;
  
  const SignInError(this.message);

  @override
  List<Object> get props => [message];
}

class SignInPasswordObscureChanged extends SignInState {
  final bool isVisible;

  const SignInPasswordObscureChanged(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}
