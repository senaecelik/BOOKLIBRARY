part of 'sign_out_cubit.dart';

abstract class SignOutState extends Equatable {
  const SignOutState();

  @override
  List<Object> get props => [];
}

final class SignOutInitial extends SignOutState {}
final class SignOutDone extends SignOutState {}
final class SignOutError extends SignOutState {
  final String errorMessage;

  const SignOutError(this.errorMessage);


  @override
  List<Object> get props => [errorMessage];
}


