import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/core/client/resources/values_manager.dart';
import 'package:flutter_project/core/widget/text/title_widget.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.register_have_an_account.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              onPressed: () {
                context.router.popAndPush(
                  const LoginRoute(),
                );
              },
              child: Text(
                LocaleKeys.register_login_now.tr(),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p20),
        child: Column(
          children: [
            TitleWidget(
              title: LocaleKeys.register_title.tr(),
            ),
            SizedBox(
              height: AppSizeHeight.s32,
            ),
            FirebaseUIActions(
              actions: [],
              child: LoginView(
                showTitle: false,
                action: AuthAction.signUp,
                providers: FirebaseUIAuth.providersFor(
                  FirebaseAuth.instance.app,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
