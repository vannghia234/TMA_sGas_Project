import 'package:flutter/material.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/src/feature/authentication/presentation/page/home_page.dart';
import 'package:sgas/src/feature/authentication/presentation/page/login_page.dart';
import 'package:sgas/src/feature/authentication/presentation/page/change_password_page.dart';
import 'package:sgas/src/feature/authentication/presentation/page/forgot_password_page.dart';
import 'package:sgas/src/feature/authentication/presentation/page/otp_page.dart';
import 'package:sgas/src/base/initial_layer/presentation/layer/initial_layer.dart';

Route appRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutePath.root:
      return MaterialPageRoute(
        builder: (context) => const InitialLayer(),
      );
    case RoutePath.home:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    case RoutePath.login:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
    case RoutePath.changePassword:
      Map<String, String> data = settings.arguments as Map<String, String>;

      return MaterialPageRoute(
        builder: (context) => ChangePasswordPage(
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
        builder: (context) => OTPPage(
          userInfo: model,
        ),
      );
    case RoutePath.home:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );

    default:
// TODO: return NotFoundPage
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  }
}
