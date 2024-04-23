import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/src/common/utils/helper/logger_helper.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_pass_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_password_controller_state.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/otp_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/reset_password_cubit.dart';

class ForgetControllerCubit extends Cubit<ForgetControllerState> {
  ForgetControllerCubit() : super(ForgetScreenState());
  String? token;
  String? username;
  String? phone;

  changeState(ForgetControllerState state) {
    emit(state);
  }

  Future forgetPassword(String username, String phoneNumber) async {
    bool success = await getIt
        .get<ForgetPasswordCubit>()
        .forgetPassword(username, phoneNumber);
    logger.d("forget status $success");
    if (success) {
      this.username = username;
      phone = phoneNumber;
      emit(OtpScreenState(phone: phoneNumber, username: username));
    }
  }

  Future sentOTP(String otp) async {
    var result =
        await getIt.get<OtpCubit>().sentOTP(username: username!, otp: otp);
    if (result.isRight) {
      token = result.right.data!;
      emit(ResetScreenState());
    }
  }

  Future resetPassword(String password, String rePassword) async {
    await getIt
        .get<ResetPasswordCubit>()
        .updatePass(password: rePassword, rePassword: rePassword);
  }
}
