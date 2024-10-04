import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:flutter_project/injection_container.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:flutter_project/widget/button/outlined_primary_button.dart';
import 'package:flutter_project/widget/text/message_text_widget.dart';
import 'package:flutter_project/widget/text/title_widget.dart';
import 'package:flutter_project/widget/textfield/e_mail_text_field.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgotPasswordCubit _forgotPasswordCubit;
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _emailController;

  @override
  void initState() {
    _forgotPasswordCubit = sl<ForgotPasswordCubit>();
    _emailController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>.value(
      value: _forgotPasswordCubit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p20, vertical: AppPadding.p30),
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: TitleWidget(title: "Şifremi Unuttum")),
                  SizedBox(
                    height: AppSizeHeight.s16,
                  ),
                  const Text(
                      "E-posta adresinizi girin. Size şifrenizi sıfırlamanız için bir bağlantı göndereceğiz."),
                  SizedBox(
                    height: AppSizeHeight.s32,
                  ),
                  EmailTextFormField(
                    emailController: _emailController,
                  ),
                  SizedBox(
                    height: AppSizeHeight.s32,
                  ),
                  OutlinedPrimaryButton(
                    child:
                        BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        return state is ForgotPasswordLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const Text("Şifreyi sıfırla");
                      },
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _forgotPasswordCubit.sendPasswordResetEmail(
                            email: _emailController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: AppSizeHeight.s16,
                  ),
                  BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (context, state) {
                      return state is ForgotPasswordDone
                          ? MessageText(message: state.message)
                          : const SizedBox.shrink();
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        context.router.maybePop();
                      },
                      child: const Text("Geri dön")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
