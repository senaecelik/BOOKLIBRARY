part of 'login_cubit.dart';

abstract class LoginState {}

final class AuthInitial extends LoginState {}

final class AuthLoading extends LoginState {
}

final class AuthGoogleLoading extends LoginState{}

final class AuthSuccess extends LoginState {}

final class AuthError extends LoginState {
  final String error;

  AuthError({required this.error});
}
