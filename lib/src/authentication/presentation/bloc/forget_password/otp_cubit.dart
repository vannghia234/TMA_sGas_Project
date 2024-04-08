import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/src/authentication/data/models/compare_otp_params.dart';
import 'package:sgas/src/authentication/data/models/forget_params.dart';
import 'package:sgas/src/authentication/domain/failure/failure.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_password/otp_state.dart';
import 'package:sgas/src/common/utils/contant/global_key.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(InitialOtp());
  final AuthenticationUseCase _useCase = AuthenticationUseCase();

  changeState(OtpState state) {
    emit(state);
  }

  sentOTP({required String username, required String otp}) async {
    var otpResult = await _useCase
        .compareOTP(CompareOTPParams(username: username, oneTimeOtp: otp));
    if (otpResult.isLeft) {
      if (otpResult.left is TimeOutOTPFailure) {
        emit(TimeOutOtp());
        return;
      } else {
        emit(IncorrectOtp());
        return;
      }
    }
    emit(CorrectOtp());
    navigatorKey.currentState?.popAndPushNamed(RoutePath.changePassword,
        arguments: <String, String>{
          "data": otpResult.right.data!,
          "username": username
        });
  }

  Future<void> reSendOtp(
      {required String username, required String phone}) async {
    var res = await _useCase
        .forgetPassword(ForgetParams(username: username, phone: phone));
    if (res.isLeft) {
      if (res.left is OverRequestForgetPasswordFailure) {
        final instance = res.left as OverRequestForgetPasswordFailure;
        emit(OverRequestOtp(mess: instance.data));
        return;
      }
    }
    emit(WaitingOtp());
  }
}
