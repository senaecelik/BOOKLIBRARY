import 'package:auto_route/auto_route.dart';
import 'package:flutter_project/presentation/auth/auth_wrapper_screen.dart';
import 'package:flutter_project/presentation/auth/create_new_password/create_new_password_screen.dart';
import 'package:flutter_project/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:flutter_project/presentation/auth/login/login_screen.dart';
import 'package:flutter_project/presentation/auth/register/register_screen.dart';
import 'package:flutter_project/presentation/home/home_screen.dart';
import 'package:flutter_project/presentation/welcome/splash_screen.dart';
import 'package:flutter_project/presentation/welcome/welcome_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
final class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(
          page: AuthWrapperRoute.page,
        ),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: CreateNewPasswordRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
