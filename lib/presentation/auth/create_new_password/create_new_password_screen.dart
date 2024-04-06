import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:flutter_project/core/widget/button/filled_primary_button.dart';
import 'package:flutter_project/core/widget/text/title_widget.dart';


@RoutePage()
class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p30),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleWidget(title: "Create new password"),
                  SizedBox(
                    height: AppSizeHeight.s16,
                  ),
                  const Text(
                      "Your new password must be unique from those previously used."),
                  SizedBox(
                    height: AppSizeHeight.s32,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) => input!.isEmpty
                        ? null
                        : "Please enter a valid new password.",
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                        labelText: "New Password",
                        hintText: "Please enter new password"),
                  ),
                  SizedBox(
                    height: AppSizeHeight.s32,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) => input!.isEmpty
                        ? null
                        : "Please enter a valid confirm password.",
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Please enter confirm password"),
                  ),
                  SizedBox(
                    height: AppSizeHeight.s32,
                  ),
                ],
              ),
            ),
            FilledPrimaryButton(
              child: const Text("Reset Password"),
              onPressed: () {
                // Navigator.pushNamed(context, Routes.otpVerificationPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
