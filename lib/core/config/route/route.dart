import 'package:flutter/material.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/src/base/validation_layer/presentation/page/data_parsing_page.dart';
import 'package:sgas/src/base/validation_layer/presentation/page/disconnect_page.dart';
import 'package:sgas/src/common/presentation/page/not_found_page.dart';
import 'package:sgas/src/feature/authentication/presentation/layer/authentication_layer.dart';
import 'package:sgas/src/feature/authentication/presentation/page/home_page.dart';
import 'package:sgas/src/feature/authentication/presentation/page/login_page.dart';
import 'package:sgas/src/feature/authentication/presentation/page/set_password_page.dart';
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
        builder: (context) => SetPasswordPage(
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
    case RoutePath.disconnect:
      return MaterialPageRoute(
        builder: (context) => const DisconnectPage(),
      );
    case RoutePath.errorVersion:
      return MaterialPageRoute(
        builder: (context) => const DataParsingPage(),
      );
       case RoutePath.authentication:
      return MaterialPageRoute(
        builder: (context) => const AuthenticationLayer(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const NotFoundPage(),
      );
  }
}
