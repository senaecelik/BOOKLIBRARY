import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;

  const UserModel({
    required this.uid,
    required this.email,
  });

  @override
  List<Object?> get props => [uid, email];
}
