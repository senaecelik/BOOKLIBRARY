import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/core/extension/email_validation.dart';
import 'package:flutter_project/presentation/auth/forgot_password/view_model/cubit/forgot_password_cubit.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:flutter_project/utility/show_snack_bar.dart';
import 'package:flutter_project/core/widget/button/filled_primary_button.dart';
import 'package:flutter_project/core/widget/text/title_widget.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p30),
        child: Column(
          children: [
            Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleWidget(title: "Forgot Password?"),
                  SizedBox(
                    height: AppSizeHeight.s16,
                  ),
                  const Text(
                      "Don't worry! It occurs. Please enter the email address linked with your account."),
                  SizedBox(
                    height: AppSizeHeight.s32,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) => input!.isValidEmail()
                        ? null
                        : "Please enter a valid email address.",
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: "Email", hintText: "Please enter email"),
                  ),
                  SizedBox(
                    height: AppSizeHeight.s32,
                  ),
                ],
              ),
            ),
            BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                } else if (state is ForgotPasswordError) {
                  showSnackBar(context: context, text: state.error.toString());
                }
              },
              builder: (context, state) {
                return FilledPrimaryButton(
                  child: state is ForgotPasswordLoading
                      ? CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onSecondary)
                      : const Text("Send Code"),
                  onPressed: () {
                    context
                        .read<ForgotPasswordCubit>()
                        .forgotPassword(email: emailController.text);
                  },
                );
              },
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember Password? ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                          onPressed: () {
                            context.router.maybePop();
                          },
                          child: const Text("Login"))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
