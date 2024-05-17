import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/app/utils/package_info/package_info.dart';
import 'package:flutter_project/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:flutter_project/widget/button/filled_primary_button.dart';
import 'package:flutter_project/widget/button/outlined_primary_button.dart';
import 'package:provider/provider.dart';


@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      initialData: null,
      create: (context) => context.read<FirebaseAuthDataSource>().getAuthStateChanges(),
      child: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: BottomAppBar(
              height: MediaQuery.of(context).size.height * .30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FilledPrimaryButton(
                    child: Text(LocaleKeys.general_button_login.tr()),
                    onPressed: () {
                      context.router.push(const SingInRoute());
                    },
                  ),
                  SizedBox(
                    height: AppSizeHeight.s14,
                  ),
                  OutlinedPrimaryButton(
                    child: Text(LocaleKeys.general_button_register.tr()),
                    onPressed: () {
                      context.router.push(const SignUpRoute());
                    },
                  ),
                  SizedBox(
                    height: AppSizeHeight.s14,
                  ),
              
                  SizedBox(
                    height: AppSizeHeight.s14,
                  ),
                  Text("V. ${PackageInfoUtils.getAppVersion()}")
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
