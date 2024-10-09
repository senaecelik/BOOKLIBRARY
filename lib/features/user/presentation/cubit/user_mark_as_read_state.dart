part of 'user_mark_as_read_cubit.dart';

sealed class UserMarkAsReadState extends Equatable {
  const UserMarkAsReadState();

  @override
  List<Object> get props => [];
}

final class UserMarkAsReadInitial extends UserMarkAsReadState {}
final class UserMarkAsReadLoading extends UserMarkAsReadState {}
final class UserMarkAsReadSuccess extends UserMarkAsReadState {}
final class UserMarkAsReadError extends UserMarkAsReadState {
  final String message;

  const UserMarkAsReadError({required this.message});
}

