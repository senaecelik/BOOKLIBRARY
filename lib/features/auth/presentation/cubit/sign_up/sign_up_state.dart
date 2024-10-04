part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {}
final class SignUpDone extends SignUpState {
    final String message;

  const SignUpDone(this.message);
    @override
  List<Object> get props => [message];

}
final class SignUpError extends SignUpState {
  final String errorMessage;

  const SignUpError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
  
}


