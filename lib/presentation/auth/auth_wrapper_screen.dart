import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/repository/authentication/firebase_auth_manger.dart';
import 'package:flutter_project/presentation/home/home_screen.dart';
import 'package:flutter_project/presentation/welcome/welcome_screen.dart';

@RoutePage()
class AuthWrapperScreen extends StatelessWidget {
  const AuthWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      if (firebaseUser.isAnonymous) {
        context.read<FirebaseAuthManager>().signOut();
        return const WelcomeScreen();
      } else {
        return const HomeScreen();
      }
    } else {
      return const WelcomeScreen();
    }
  }
}
