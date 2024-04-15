import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/language/app_localization.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/core/client/resources/values_manager.dart';
import 'package:flutter_project/core/widget/text/title_widget.dart';
import 'package:flutter_project/utility/constant/enum/locales.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        PopupMenuButton<String>(
          position: PopupMenuPosition.under,
          icon: const Icon(Icons.language_outlined),
          onSelected: (String value) {
            setState(() {});
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              onTap: () {
                AppLocalization.updateLanguage(
                    context: context, value: Locales.tr);
              },
              value: '1',
              child: Text(LocaleKeys.general_language_tr.tr()),
            ),
            PopupMenuItem(
              value: '2',
              onTap: () {
                AppLocalization.updateLanguage(
                    context: context, value: Locales.en);
              },
              child: Text(LocaleKeys.general_language_en.tr()),
            ),
          ],
        )
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.login_dont_you_have_an_account.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              onPressed: () {
                context.router.push(const RegisterRoute());
              },
              child: Text(
                LocaleKeys.login_register_now.tr(),
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
              title: LocaleKeys.login_title.tr(),
            ),
            SizedBox(
              height: AppSizeHeight.s32,
            ),
            FirebaseUIActions(
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  if (!state.user!.emailVerified) {
                    context.router.push(EmailVerifyRoute());
                  } else {
                    context.router.pushAndPopUntil(
                      const HomeRoute(),
                      predicate: (route) => false,
                    );
                  }
                }),
              ],
              child: LoginView(
                showTitle: false,
                showPasswordVisibilityToggle: true,
                action: AuthAction.signIn,
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
