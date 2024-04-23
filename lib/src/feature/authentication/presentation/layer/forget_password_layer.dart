import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/src/common/presentation/page/app_loading_page.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_password_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_password_controller_state.dart';
import 'package:sgas/src/feature/authentication/presentation/page/forget_password_page.dart';
import 'package:sgas/src/feature/authentication/presentation/page/otp_page.dart';
import 'package:sgas/src/feature/authentication/presentation/page/reset_password_page.dart';

class ForgetPasswordLayer extends StatelessWidget {
  const ForgetPasswordLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetControllerCubit, ForgetControllerState>(
      bloc: getIt.get<ForgetControllerCubit>(),
      builder: (context, state) {
        if (state is ForgetScreenState) {
          return const ForgetPasswordPage();
        }
        if (state is OtpScreenState) {
          return const OTPPage();
        }
        if (state is ResetScreenState) {
          return const ResetPasswordPage();
        }
        return const AppLoadingPage();
      },
    );
  }
}
