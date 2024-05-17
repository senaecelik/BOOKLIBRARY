import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/features/auth/presentaion/cubit/sign_up/sign_up_cubit.dart';
import 'package:flutter_project/injection_container.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:flutter_project/widget/button/outlined_primary_button.dart';
import 'package:flutter_project/widget/text/message_text_widget.dart';
import 'package:flutter_project/widget/text/title_widget.dart';
import 'package:flutter_project/widget/textfield/e_mail_text_field.dart';
import 'package:flutter_project/widget/textfield/password_text_field.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  late SignUpCubit _signUpCubit;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController,
      _emailController,
      _passwordController;

  @override
  void initState() {
    _signUpCubit = sl<SignUpCubit>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>.value(
      value: _signUpCubit,
      child: Scaffold(
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
                    const SingInRoute(),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TitleWidget(
                  
                  title: LocaleKeys.register_title.tr(),
                ),
                SizedBox(
                  height: AppSizeHeight.s32,
                ),
                SizedBox(
                  height: AppSizeHeight.s16,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Adı"),
                  controller: _nameController,
                ),
                SizedBox(
                  height: AppSizeHeight.s16,
                ),
                EmailTextFormField(emailController: _emailController),
                SizedBox(
                  height: AppSizeHeight.s16,
                ),
                PasswordTextFormField(passwordController: _passwordController),
                SizedBox(
                  height: AppSizeHeight.s16,
                ),
                OutlinedPrimaryButton(
                    child: BlocConsumer<SignUpCubit, SignUpState>(
                      listener: (context, state) {
                          state is SignUpDone
                            ? context.router.pushAndPopUntil(
                                const HomeRoute(),
                                predicate: (route) => false,
                              )
                            : null;
                      },
                      builder: (context, state) {
                        return state is SignUpLoading
                            ? const CircularProgressIndicator.adaptive()
                            : Text(LocaleKeys.general_button_register.tr());
                      },
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signUpCubit.signUp(
                            userName: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text);
                      }
                    }),
                SizedBox(
                  height: AppSizeHeight.s16,
                ),
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return state is SignUpError
                        ? MessageText(message: state.errorMessage,)
                        : Spacer();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
