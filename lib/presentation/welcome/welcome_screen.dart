import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/data/repository/authentication/firebase_auth_manger.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/presentation/auth/login/view_model/cubit/login_cubit.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:flutter_project/utility/show_snack_bar.dart';
import 'package:flutter_project/core/widget/button/filled_primary_button.dart';
import 'package:flutter_project/core/widget/button/outlined_primary_button.dart';
import 'package:provider/provider.dart';

//TODO: Image eklenecek ve string değerleri yönetilebileceği utils sınıfları yapılacak

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      initialData: null,
      create: (context) => context.read<FirebaseAuthManager>().authState,
      child: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: BottomAppBar(
              height: MediaQuery.of(context).size.height * .25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FilledPrimaryButton(
                    child: Text(LocaleKeys.general_button_login.tr()),
                    onPressed: () {
                      context.router.push(const LoginRoute());
                    },
                  ),
                  SizedBox(
                    height: AppSizeHeight.s14,
                  ),
                  OutlinedPrimaryButton(
                    child: Text(LocaleKeys.general_button_register.tr()),
                    onPressed: () {
                      context.router.push(const RegisterRoute());
                    },
                  ),
                  SizedBox(
                    height: AppSizeHeight.s14,
                  ),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        context.router.pushAndPopUntil(
                          const HomeRoute(),
                          predicate: (route) => false,
                        );
                      } else if (state is AuthError) {
                        showSnackBar(context: context, text: state.error);
                      }
                    },
                    builder: (context, state) {
                      return TextButton(
                          onPressed: () {
                            context.read<LoginCubit>().signInAnonymously();
                          },
                          child: Text(
                              LocaleKeys.welcome_continue_as_a_guest.tr()));
                    },
                  )
                ],
              ),
            ),
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return state is AuthLoading
                  ? Stack(
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        ModalBarrier(
                          dismissible: true,
                          barrierSemanticsDismissible: true,
                            color:
                                Theme.of(context).shadowColor.withOpacity(0.5)),
                      ],
                    )
                  : const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
