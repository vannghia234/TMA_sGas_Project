// ignore_for_file: use_build_context_synchronously
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/util/controller/snack_bar_controller.dart';
import 'package:sgas/src/feature/authentication/data/model/compare_otp_params.dart';
import 'package:sgas/src/feature/authentication/data/model/forget-password_params.dart';
import 'package:sgas/src/feature/authentication/data/model/otp_model.dart';
import 'package:sgas/src/feature/authentication/domain/failure/failure.dart';
import 'package:sgas/src/feature/authentication/domain/usecase/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(InitialOtp());
  final AuthenticationUseCase _useCase = AuthenticationUseCase();

  changeState(OtpState state) {
    emit(state);
  }

  Future<Either<Failure, OTPModel>> sentOTP({
    required String username,
    required String otp,
  }) async {
    var otpResult = await _useCase
        .compareOTP(CompareOTPParams(username: username, oneTimeOtp: otp));

    if (otpResult.isLeft) {
      if (otpResult.left is TimeOutOTPFailure) {
        emit(TimeOutOtp());
        return Left(otpResult.left);
      }
      if (otpResult.left is ServerFailure) {
        showSnackBar(
            content: S.current.txt_no_network_connection,
            state: SnackBarState.error);
        return Left(otpResult.left);
      } else {
        showSnackBar(
            content: S.current.txt_invalid_otp, state: SnackBarState.error);
        return Left(otpResult.left);
      }
    }
    // emit(CorrectOtp(data: otpResult.right.data!, username: username));
    emit(CorrectOtp());
    return Right(otpResult.right);
  }

  Future<void> reSendOtp(
      {required String username, required String phone}) async {
    var res = await _useCase
        .forgetPassword(ForgetPasswordParams(username: username, phone: phone));
    if (res.isLeft) {
      if (res.left is OverRequestForgetPasswordFailure) {
        showSnackBar(
            content: S.current.txt_please_wait_a_minute_to_send_otp,
            state: SnackBarState.error);
      }
      if (res.left is ServerFailure) {
        showSnackBar(
            content: S.current.txt_no_network_connection,
            state: SnackBarState.error);
      }
      return;
    }
    emit(WaitingOtp());
  }
}
