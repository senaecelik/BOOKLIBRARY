import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/language/app_localization.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/features/auth/presentaion/cubit/sign_in/sign_in_cubit.dart';
import 'package:flutter_project/features/auth/presentaion/widget/sign_in_google_button.dart';
import 'package:flutter_project/injection_container.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:flutter_project/widget/button/outlined_primary_button.dart';
import 'package:flutter_project/widget/text/message_text_widget.dart';
import 'package:flutter_project/widget/text/title_widget.dart';
import 'package:flutter_project/utility/constant/enum/locales.dart';
import 'package:flutter_project/widget/textfield/e_mail_text_field.dart';
import 'package:flutter_project/widget/textfield/password_text_field.dart';

@RoutePage()
class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  late SignInCubit _singInCubit;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    _singInCubit = sl<SignInCubit>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (context) => _singInCubit,
      child: Scaffold(
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
                  context.router.push(const SignUpRoute());
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TitleWidget(
                  title: LocaleKeys.login_title.tr(),
                ),
                SizedBox(
                  height: AppSizeHeight.s32,
                ),
                EmailTextFormField(emailController: _emailController),
                SizedBox(
                  height: AppSizeHeight.s12,
                ),
                BlocBuilder<SignInCubit, SignInState>(
                  builder: (context, state) {
                    return PasswordTextFormField(
                      passwordController: _passwordController,
                      obscureText: context.read<SignInCubit>().isVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          context.read<SignInCubit>().changePasswordObscure();
                        },
                        icon: context.read<SignInCubit>().isVisible
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: AppSizeHeight.s6,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          context.router.push(const ForgotPasswordRoute());
                        },
                        child: Text(LocaleKeys.login_forgot_pass.tr()))),
                SizedBox(
                  height: AppSizeHeight.s6,
                ),
                OutlinedPrimaryButton(
                    child: BlocConsumer<SignInCubit, SignInState>(
                      listener: (context, state) {
                        state is SignInSuccess
                            ? context.router.pushAndPopUntil(
                                const HomeRoute(),
                                predicate: (route) => false,
                              )
                            : null;
                      },
                      builder: (context, state) {
                        return state is SignInLoading
                            ? const CircularProgressIndicator.adaptive()
                            : Text(LocaleKeys.general_button_login.tr());
                      },
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _singInCubit.signIn(
                            email: _emailController.text,
                            password: _passwordController.text);
                      }
                    }),
                SizedBox(
                  height: AppSizeHeight.s16,
                ),
                BlocBuilder<SignInCubit, SignInState>(
                  builder: (context, state) {
                    return state is SignInError
                        ? MessageText(
                            message: state.message,
                          )
                        : const Spacer();
                  },
                ),
                // SignInGoogleButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
