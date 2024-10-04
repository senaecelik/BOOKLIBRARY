import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/app/theme/app_theme_provider.dart';
import 'package:flutter_project/app/theme/dark/app_dark_theme.dart';
import 'package:flutter_project/app/theme/light/app_light_theme.dart';
import 'package:flutter_project/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_project/injection_container.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

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
        BlocProvider(create: (_) => sl<AuthCubit>()..appStarted(context)),

        // Provider<FirebaseAuthDataSource>(
        //   create: (_) => FirebaseAuthDataSource(FirebaseAuth.instance),
        // ),
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(),
        ),
        // BlocProvider<RemoteBestSellerBookCubit>(create: (_) => sl()),
      ],
      child: Consumer<AppThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp.router(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              FirebaseUILocalizations.delegate,
              EasyLocalization.of(context)!.delegate,
            ],
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
