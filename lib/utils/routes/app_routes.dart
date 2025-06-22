import 'package:expense_app/ui/home/main_screen.dart';
import 'package:flutter/widgets.dart';

import '../../ui/login/login_screen.dart';
import '../../ui/sign_up/sign_up_screen.dart';
import '../../ui/splash/splash_screen.dart';

class AppRoutes {
  static const String splashPage = "/splash";
  static const String loginPage = "/login";
  static const String registerPage = "/register";
  static const String mainPage = "/main";

  static Map<String, Widget Function(BuildContext)> routes = {
    splashPage: (context) => SplashScreen(),
    loginPage: (context) => LoginScreen(),
    registerPage: (context) => SignUpScreen(),
    mainPage: (context) => MainScreen(),
  };
}
