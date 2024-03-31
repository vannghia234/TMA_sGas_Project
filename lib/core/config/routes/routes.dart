import 'package:flutter/material.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/src/authentication/presentation/page/login_page.dart';
import 'package:sgas/src/authentication/presentation/page/change_new_password_page.dart';
import 'package:sgas/src/authentication/presentation/page/forgot_password_page.dart';
import 'package:sgas/src/authentication/presentation/page/recieve_otp_page.dart';
import 'package:sgas/src/authentication/presentation/page/wrapper_page.dart';

Route appRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutePath.login:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
    case RoutePath.ChangeNewPassword:
      Map<String, String> data = settings.arguments as Map<String, String>;

      return MaterialPageRoute(
        builder: (context) => ChangeNewPasswordPage(
          data: data,
        ),
      );
    case RoutePath.forgotPassword:
      return MaterialPageRoute(
        builder: (context) => const ForgotPasswordPage(),
      );
    case RoutePath.receiveOTP:
      Map<String, String> model = settings.arguments as Map<String, String>;
      return MaterialPageRoute(
        builder: (context) => RecieveOTPPage(
          userInfo: model,
        ),
      );
    case RoutePath.wrapper:
      return MaterialPageRoute(
        builder: (context) => const Wrapper(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  }
}
