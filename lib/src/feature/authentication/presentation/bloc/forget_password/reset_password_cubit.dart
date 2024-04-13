import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/feature/authentication/data/models/reset_password_params.dart';
import 'package:sgas/src/feature/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/common/utils/constant/global_key.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/reset_password_state.dart';

import '../../../../../common/utils/controller/snack_bar_controller.dart';

class SetPasswordCubit extends Cubit<ResetPasswordState> {
  SetPasswordCubit() : super(InitialResetPassWord());
  AuthenticationUseCase useCase = AuthenticationUseCase();

  void changeState(ResetPasswordState state) {
    emit(state);
  }

  Future updatePass(
      {required String token,
      required String password,
      required String rePassword,
      required String username}) async {
    if (rePassword.isEmpty) {
      emit(InValidReEnterPassword(
          message: S.current.txt_please_enter_re_password));
      return;
    } else if (password != rePassword) {
      emit(InValidReEnterPassword(message: S.current.txt_not_match_password));
      return;
    } else {
      emit(InitialResetPassWord());
      var result = await useCase.resetPassword(ResetPasswordParams(
          token: token, username: username, newPassword: password));
      if (result.isLeft) {
        showSnackBar(
            content: S.current.txt_no_network_connection,
            state: SnackBarState.error);
        return;
      }
      if (result.isRight) {
        emit(SuccessValidPassword());
        navigatorKey.currentState?.popAndPushNamed(RoutePath.login);
      }
    }
  }
}