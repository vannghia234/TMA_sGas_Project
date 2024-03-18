import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/constants/constants.dart';
import 'package:sgas/routes/route_path.dart';
import 'package:sgas/src/authentication/domain/entities/forget_password_entity.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/view/bloc/forget_pass_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(InititalForgetState());
  AuthenticationUseCase au = AuthenticationUseCase();

  void changeState(ForgetPasswordState state) {
    emit(state);
  }

  Future<void> handleForgetPasswordEvent(
      BuildContext context, String username, String phoneNumber) async {
    if (username.isEmpty) {
      changeState(
          InvalidForgetUsername(message: "Không được để trống tên đăng nhập"));
    } else if (username.length < 6) {
      changeState(InvalidForgetUsername(
          message: "Tên đăng nhập không nhỏ hơn 6 kí tự"));
    } else if (phoneNumber.isEmpty) {
      changeState(InvalidForgetPhoneNumber(
          message: "Không được để trống số điện thoại"));
    } else if (phoneNumberRegex.hasMatch(phoneNumber) == false) {
      changeState(
          InvalidForgetPhoneNumber(message: "Số điện thoại không hợp lệ"));
    } else {
      changeState(ValidForget());
      ForgetPasswordEntity entity =
          ForgetPasswordEntity(username: username, phone: phoneNumber);

      var res = await au.forgetPassword(entity);
      if (res.code == 200) {
        Navigator.pushNamed(context, RoutePath.recieveOTP,
            arguments: {"userName": username, "phone": phoneNumber});
      } else if (res.code == 404) {
        // ignore: use_build_context_synchronously
        changeState(InvalidForgetUsername(message: "Tài khoản không tồn tại"));
      } else if (res.code == 40015) {
        changeState(
            InvalidForgetPhoneNumber(message: "Số điện thoại không tồn tại"));
      }
    }
  }
}
