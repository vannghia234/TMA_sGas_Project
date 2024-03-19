import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/src/authentication/data/models/otp_model.dart';
import 'package:sgas/src/authentication/domain/entities/compare_otp_entity.dart';
import 'package:sgas/src/authentication/domain/entities/forget_password_entity.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/view/bloc/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(InitialOtp());
  AuthenticationUseCase usecase = AuthenticationUseCase();
  void changeState(OtpState state) {
    emit(state);
  }

  Future<void> reSendOtp(
      {required String userName, required String phone}) async {
    ForgetPasswordEntity entity =
        ForgetPasswordEntity(username: userName, phone: phone);
    var res = await usecase.forgetPassword(entity);
    if (res.code == 200) {
      changeState(WaittingOtp());
    } else if (res.code == 400) {
      
      changeState(OverRequestOtp(mess: res.data!));
    }
  }

  Future<OtpModel> sendOtp(
      {required String userName, required String otpCode}) async {
    CompareOtpEntity entity =
        CompareOtpEntity(userName: userName, otpCode: otpCode);
    var res = await usecase.compareOtp(entity);
    if (res.code == 40016) {
      changeState(IncorrectOtp());
    }
    return res;
  }
}
