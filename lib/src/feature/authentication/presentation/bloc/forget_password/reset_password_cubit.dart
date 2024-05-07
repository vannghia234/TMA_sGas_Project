import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/feature/authentication/data/model/reset_password_params.dart';
import 'package:sgas/src/feature/authentication/domain/usecase/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_password_controller.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/reset_password_state.dart';

import '../../../../../common/util/controller/snack_bar_controller.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(InitialResetPassWord());
  AuthenticationUseCase useCase = AuthenticationUseCase();

  void changeState(ResetPasswordState state) {
    emit(state);
  }

  Future updatePass(
      {required String password, required String rePassword}) async {
    if (rePassword.isEmpty) {
      emit(InValidReEnterPassword(
          message: S.current.txt_please_enter_re_password));
      return;
    } else if (password != rePassword) {
      emit(InValidReEnterPassword(message: S.current.txt_not_match_password));
      return;
    } else {
      emit(InitialResetPassWord());
      String? token = getIt.get<ForgetControllerCubit>().token;
      String? username = getIt.get<ForgetControllerCubit>().username;

      var result = await useCase.resetPassword(ResetPasswordParams(
          token: token!, username: username!, newPassword: password));

      if (result.isLeft) {
        showSnackBar(
            content: S.current.txt_no_network_connection,
            state: SnackBarState.error);
        return;
      }
      if (result.isRight) {
        emit(SuccessValidPassword());
        showSnackBar(content: S.current.txt_set_password_successfully);
        await Future.delayed(const Duration(milliseconds: 600));
      }
    }
  }
}
