import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/src/authentication/data/models/change_password_params.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_password/change_password_state.dart';
import 'package:sgas/src/common/utils/contant/global_key.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(InitialChangePassWord());
  AuthenticationUseCase useCase = AuthenticationUseCase();

  void changeState(ChangePasswordState state) {
    emit(state);
  }

  Future updatePass(
      {required String token,
      required String password,
      required String rePassword,
      required String username}) async {
    if (rePassword.isEmpty) {
      emit(InValidRePassword(message: "Vui lòng nhập lại mật khẩu"));
      return;
    } else if (password != rePassword) {
      emit(InValidRePassword(message: "Mật khẩu không khớp"));
      return;
    } else {
      var result = await useCase.changePassword(ChangePasswordParams(
          token: token, username: username, newPassword: password));
      if (result.isLeft) {
        if (result.left is BadRequestFailure) {
          // todo : kiểu có thể thay đổi mật khẩu 2 lần giống nhau, kiểu không biết cái token có expired không, tạm chưa xử lý chổ này
          return;
        }
      }
      if (result.isRight) {
        emit(SuccessValidPassword());
        navigatorKey.currentState?.popAndPushNamed(RoutePath.login);
      }
    }
  }
}
