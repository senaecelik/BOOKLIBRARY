// ignore_for_file: overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  @override
  final String uid;
  @override
  final String? username;
  @override
  final String? name;
  @override
  final String? email;

  const UserModel({
    required this.uid,
    this.username,
    this.name,
    this.email,
  }) : super(
          uid: uid,
          username: username,
          name: name,
          email: email,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      username: snapshot['username'],
      uid: snapshot['uid'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "username": username,
      };
}
