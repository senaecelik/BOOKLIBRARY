// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_project/app/language/locale_keys.g.dart';
// import 'package:flutter_project/features/auth/presentaion/cubit/sign_in_google/sign_in_google_cubit.dart';
// import 'package:flutter_project/injection_container.dart';
// import 'package:flutter_project/widget/button/outlined_icon_primary_button.dart';

// class SignInGoogleButton extends StatefulWidget {
//   const SignInGoogleButton({
//     super.key,
//   });

//   @override
//   State<SignInGoogleButton> createState() => _SignInGoogleButtonState();
// }


// class _SignInGoogleButtonState extends State<SignInGoogleButton> {

//    late SignInGoogleCubit _googleCubit;
//   @override
//   void initState() {

// _googleCubit = sl<SignInGoogleCubit>();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<SignInGoogleCubit>.value(
//       value:_googleCubit,
//     child: OutlinedIconPrimaryButton(
//             icon: BlocBuilder<SignInGoogleCubit, SignInGoogleState>(
//               builder: (context, state) {
//                 return state is SignInGoogleLoading
//                     ? const CircularProgressIndicator.adaptive()
//                     : const Icon(Icons.abc); // added to google icon
//               },
//             ),
//             child: Text(LocaleKeys.general_button_sign_in_with_google.tr()),
//             onPressed: () {
//              _googleCubit.signInGoogle();
//             }));
//   }
// }
