part of 'register_cubit.dart';

abstract class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

final class RegisterError extends RegisterState {
  final String error;

  RegisterError({required this.error});
}

final class RegisterLoading extends RegisterState {}

final class RegisterCheckValid extends RegisterState {
  final bool isValid;

  RegisterCheckValid({required this.isValid});
}
