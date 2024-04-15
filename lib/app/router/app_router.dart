import 'package:auto_route/auto_route.dart';
import 'package:flutter_project/presentation/auth/auth_wrapper_screen.dart';
import 'package:flutter_project/presentation/auth/email_verify_screen.dart';
import 'package:flutter_project/presentation/auth/login_screen.dart';
import 'package:flutter_project/presentation/auth/register_screen.dart';
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
        AutoRoute(page: EmailVerifyRoute.page),

        // AutoRoute(page: CreateNewPasswordRoute.page),
      //AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
