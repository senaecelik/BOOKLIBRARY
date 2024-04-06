import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/presentation/auth/login/view_model/cubit/login_cubit.dart';
import 'package:flutter_project/core/widget/button/outlined_icon_primary_button.dart';

class GoogleSignInButton extends StatelessWidget {
   const GoogleSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return OutlinedIconPrimaryButton(
          icon: state is AuthGoogleLoading
              ? const CircularProgressIndicator()
              : const Icon(Icons.abc), // added to google icon
          child: Text(LocaleKeys.general_button_sign_in_with_google.tr()),
          onPressed: () {
            context.read<LoginCubit>().signInGoogle();
          },
        );
      },
    );
  }
}
