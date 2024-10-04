import 'package:flutter_project/features/auth/domain/entity/user_entity.dart';

class UserStaticModel {
  static String? uid;
  static String? username;
  static String? name;
  static String? email;

  static void updateUser(UserEntity user) {
    uid = user.uid;
    username = user.username;
    name = user.name;
    email = user.email;
  }
}
