
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/theme/app_theme_provider.dart';
import 'package:flutter_project/app/theme/dark/app_dark_theme.dart';
import 'package:flutter_project/app/theme/light/app_light_theme.dart';
import 'package:flutter_project/data/repository/authentication/firebase_auth_manger.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/presentation/auth/forgot_password/view_model/cubit/forgot_password_cubit.dart';
import 'package:flutter_project/presentation/auth/login/view_model/cubit/login_cubit.dart';
import 'package:flutter_project/presentation/auth/register/view_model/cubit/register_cubit.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final _appRouter = AppRouter();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthManager>(
          create: (_) => FirebaseAuthManager(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(),
        ),
        Provider<LoginCubit>(create: (_) => LoginCubit()),
        Provider<RegisterCubit>(create: (_) => RegisterCubit()),
        Provider<ForgotPasswordCubit>(create: (_) => ForgotPasswordCubit()),
        
        StreamProvider(
            initialData: null,
            create: (context) => context.read<FirebaseAuthManager>().authState)
      ],
      child: Consumer<AppThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: _appRouter.config(),
            debugShowCheckedModeBanner: false,
            title: 'Sena ÇELİK',
            theme: AppLightTheme().themeData,
            darkTheme: AppDarkTheme().themeData,
            themeMode: value.themeMode,
          );
        },
      ),
    );
  }
}
