import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/core/utils/helper/pattern_regex_helper.dart';
import 'package:sgas/src/authentication/data/models/forget_params.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_pass_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(InitialForgetState());
  final _usecase = AuthenticationUseCase();

  Future<void> forgetPassword(String username, String phoneNumber) async {
    if (username.isEmpty) {
      emit(InvalidForgetUsernameState(message: "bạn chưa nhập tên đăng nhập"));
    } else if (username.length < 6) {
      emit(InvalidForgetUsernameState(
          message: "Tên đăng nhập không nhỏ hơn 6 kí tự"));
    } else if (phoneNumber.isEmpty) {
      emit(InvalidForgetPhoneNumberState(
          message: "bạn chưa nhập số điện thoại"));
    } else if (phoneNumberRegex.hasMatch(phoneNumber) == false) {
      emit(InvalidForgetPhoneNumberState(
          message: "Số điện thoại phải có 10 kí tự"));
    } else {
      emit(InitialForgetState());
      ForgetParams params =
          ForgetParams(username: username, phone: phoneNumber);
      var result = await _usecase.forgetPassword(params);
      if (result.isLeft) {
        if (result.left is NotFoundFailure) {
          emit(InvalidForgetUsernameState(
              message: "Không tìm thấy tài khoản này"));
        } else if (result.left is BadRequestFailure) {
          var instance = result.left as BadRequestFailure;
          if (instance.statusCode == 400) {
            emit(InvalidForgetPhoneNumberState(
                message: "Số điện thoại không chính xác"));
          } else {
            emit(InvalidForgetPhoneNumberState(message: "${instance.data}"));
          }
        }
      }
      if (result.isRight) emit(ValidatedForgetState());
    }
  }
}
