import 'package:auto_route/auto_route.dart';
import 'package:flutter_project/features/auth/presentation/pages/auth_wrapper_screen.dart';
import 'package:flutter_project/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:flutter_project/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:flutter_project/features/auth/presentation/pages/sing_up_screen.dart';
import 'package:flutter_project/features/books/presentation/pages/find_book_screen.dart';
import 'package:flutter_project/features/books/presentation/pages/find_isbn_book_screen.dart';
import 'package:flutter_project/features/home/presentation/home_screen.dart';
import 'package:flutter_project/features/welcome/presentation/splash_screen.dart';
import 'package:flutter_project/features/welcome/presentation/welcome_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
final class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: AuthWrapperRoute.page),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: SingInRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: FindBookRoute.page),
        AutoRoute(page: FindIsbnBookRoute.page),


        AutoRoute(page: ForgotPasswordRoute.page),



      ];
}
