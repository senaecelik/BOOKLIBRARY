import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/presentation/auth/register/view_model/cubit/register_cubit.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:flutter_project/utility/show_snack_bar.dart';
import 'package:flutter_project/core/widget/bottom_app_bar/bottom_app_bar.dart';
import 'package:flutter_project/core/widget/button/google_sign_in_button.dart';
import 'package:flutter_project/core/widget/text/title_widget.dart';
import 'package:flutter_project/core/widget/textfield/e_mail_text_field.dart';
import 'package:flutter_project/core/widget/textfield/password_text_field.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: _buildBottomBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p30,
        ),
        child: SingleChildScrollView(
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: _registerCubitListener,
            builder: _buildRegisterPageContent,
          ),
        ),
      ),
    );
  }

  BottomRowAppBar _buildBottomBar(BuildContext context) {
    return BottomRowAppBar(
      text: LocaleKeys.register_have_an_account.tr(),
      buttonText: LocaleKeys.register_login_now.tr(),
      onPressed: () {
        context.router.maybePop();
      },
    );
  }

  void _registerCubitListener(BuildContext context, RegisterState state) {
    if (state is RegisterSuccess) {
      showSnackBar(context: context, text: "Successfuly. Please login");
    } else if (state is RegisterError) {
      showSnackBar(context: context, text: state.error.toString());
    }
  }

  Widget _buildRegisterPageContent(BuildContext context, RegisterState state) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TitleWidget(
                title: LocaleKeys.register_title.tr(),
              ),
              SizedBox(height: AppSizeHeight.s32),
              EmailTextFormField(
                emailController: _emailController,
              ),
              SizedBox(height: AppSizeHeight.s14),
              _buildPasswordFormField(),
              SizedBox(height: AppSizeHeight.s14),
            ],
          ),
        ),
        SizedBox(height: AppSizeHeight.s32),
        FilledButton(
          child: _buildSignUpButtonContent(state),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<RegisterCubit>().singUp(
                  email: _emailController.text,
                  password: _passwordController.text);
            }
          },
        ),
        SizedBox(height: AppSizeHeight.s32),
        _buildOrRegisterWithText(),
        SizedBox(height: AppSizeHeight.s12),
        _buildGoogleSignInButton(),
        SizedBox(height: AppSizeHeight.s12),
      ],
    );
  }

  Widget _buildPasswordFormField() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return PasswordTextField(
          passwordController: _passwordController,
          obscureText: true,
          onChanged: _onPasswordChanged,
          errorText: _getErrorText(state),
        );
      },
    );
  }

  Widget _buildSignUpButtonContent(RegisterState state) {
    return state is RegisterLoading
        ? CircularProgressIndicator(
            color: Theme.of(context).colorScheme.background)
        : Text(LocaleKeys.general_button_register.tr());
  }

  Widget _buildOrRegisterWithText() {
    return Row(
      children: [
        const Expanded(child: Divider(endIndent: 10)),
        Text(LocaleKeys.register_or_resigter_with.tr()),
        const Expanded(child: Divider(indent: 10)),
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    return const GoogleSignInButton();
  }

  void _onPasswordChanged(String val) {
    context.read<RegisterCubit>().validatePassword(val);
  }

  String? _getErrorText(RegisterState state) {
    if (state is RegisterCheckValid && state.isValid == false) {
      return context.read<RegisterCubit>().passwordModel.error;
    }
    return null;
  }
}
