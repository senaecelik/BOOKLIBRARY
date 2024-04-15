import 'package:auto_route/auto_route.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/router/app_router.dart';

@RoutePage()
class EmailVerifyScreen extends StatelessWidget {
  const EmailVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmailVerificationScreen(
        actions: [
          EmailVerifiedAction(() {
            context.router.push(HomeRoute());
          }),
          AuthCancelledAction((context) {
            FirebaseUIAuth.signOut(context: context);
            context.router.pushAndPopUntil(
              const LoginRoute(),
              predicate: (route) => false,
            );
          }),
        ],
      ),
    );
  }
}
