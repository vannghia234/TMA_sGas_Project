import 'package:flutter/material.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/src/authentication/presentation/page/login_page.dart';
import 'package:sgas/src/authentication/presentation/page/change_new_password_page.dart';
import 'package:sgas/src/authentication/presentation/page/forgot_password_page.dart';
import 'package:sgas/src/authentication/presentation/page/recieve_otp_page.dart';
import 'package:sgas/src/authentication/presentation/page/wrapper_page.dart';

Map<String, WidgetBuilder> routes = {
  RoutePath.wrapper: (context) => const Wrapper(),
  RoutePath.login: (context) => const LoginPage(),
  RoutePath.forgotPassword: (context) => const ForgotPasswordPage(),
  RoutePath.receiveOTP: (context) => const RecieveOTPPage(),
  RoutePath.changNewPassword: (context) => const ChangeNewPasswordPage()
};
