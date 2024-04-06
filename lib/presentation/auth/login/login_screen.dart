import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/language/app_localization.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/presentation/auth/login/view_model/cubit/login_cubit.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:flutter_project/utility/constant/enum/locales.dart';
import 'package:flutter_project/utility/show_snack_bar.dart';
import 'package:flutter_project/core/widget/bottom_app_bar/bottom_app_bar.dart';
import 'package:flutter_project/core/widget/button/filled_primary_button.dart';
import 'package:flutter_project/core/widget/button/google_sign_in_button.dart';
import 'package:flutter_project/core/widget/text/title_widget.dart';
import 'package:flutter_project/core/widget/textfield/e_mail_text_field.dart';
import 'package:flutter_project/core/widget/textfield/password_text_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p30,
        ),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: _loginCubitListener,
          builder: _buildLoginPageContent,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomRowAppBar(
      text: LocaleKeys.login_dont_you_have_an_account.tr(),
      buttonText: LocaleKeys.login_register_now.tr(),
      onPressed: () {
        context.router.push(const RegisterRoute());
      },
    );
  }

  void _loginCubitListener(BuildContext context, LoginState state) {
    if (state is AuthSuccess) {
      context.router.pushAndPopUntil(
        const HomeRoute(),
        predicate: (route) => false,
      );

      // Navigator.pushNamedAndRemoveUntil(
      //     context, Routes.homePage, (Route<dynamic> route) => false);
    } else if (state is AuthError) {
      showSnackBar(context: context, text: state.error.toString());
    }
  }

  Widget _buildLoginPageContent(BuildContext context, LoginState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildLoginForm(),
          _buildForgotPasswordButton(),
          SizedBox(height: AppSizeHeight.s32),
          _buildLoginButton(state),
          SizedBox(height: AppSizeHeight.s32),
          _buildOrLoginWithText(),
          SizedBox(height: AppSizeHeight.s12),
          _buildGoogleSignInButton(),
          SizedBox(height: AppSizeHeight.s12),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TitleWidget(
            title: LocaleKeys.login_title.tr(),
          ),
          SizedBox(height: AppSizeHeight.s32),
          EmailTextFormField(emailController: _emailController),
          SizedBox(height: AppSizeHeight.s14),
          PasswordTextField(
            passwordController: _passwordController,
            obscureText: context.read<LoginCubit>().isChecked ? true : false,
            suffixIcon: IconButton(
              onPressed: () {
                context.read<LoginCubit>().isVisible();
              },
              icon: context.read<LoginCubit>().isChecked
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          context.router.push(const ForgotPasswordRoute());
        },
        child: Text(
          LocaleKeys.login_forgot_pass.tr(),
        ),
      ),
    );
  }

  Widget _buildLoginButton(LoginState state) {
    return FilledPrimaryButton(
      icon: state is AuthLoading
          ? const CircularProgressIndicator()
          : const Icon(Icons.login),
       isDisable: state is AuthLoading ? true : false,
      child: Text(
        LocaleKeys.general_button_login.tr(),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<LoginCubit>().signInWithEmail(
                email: _emailController.text,
                password: _passwordController.text,
              );
        }
      },
    );
  }

  Widget _buildOrLoginWithText() {
    return Row(
      children: [
        const Expanded(child: Divider(endIndent: 10)),
        Text(LocaleKeys.login_or_login_with.tr()),
        const Expanded(child: Divider(indent: 10)),
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    return const GoogleSignInButton();
  }
}
