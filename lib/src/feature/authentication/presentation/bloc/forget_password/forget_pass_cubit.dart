import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/utils/controller/snack_bar_controller.dart';
import 'package:sgas/src/common/utils/helper/string_regex_helper.dart';
import 'package:sgas/src/feature/authentication/data/models/forget_params.dart';
import 'package:sgas/src/feature/authentication/domain/failure/failure.dart';
import 'package:sgas/src/feature/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_pass_state.dart';
import 'package:sgas/src/common/utils/constant/global_key.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(InitialForgetState());
  final _useCase = AuthenticationUseCase();

  Future<void> forgetPassword(String username, String phoneNumber) async {
    if (username.isEmpty) {
      emit(InvalidForgetUsernameState(
          message: S.current.txt_please_enter_username));
    } else if (username.length < 6) {
      emit(InvalidForgetUsernameState(
          message: S.current.txt_at_least_6_characters_username));
    } else if (phoneNumber.isEmpty) {
      emit(InvalidForgetPhoneNumberState(
          message: S.current.txt_please_enter_phone_number));
    } else if (!RegExp(phoneNumberRegex).hasMatch(phoneNumber)) {
      emit(InvalidForgetPhoneNumberState(
          message: S.current.txt_at_least_10_character_phone));
    } else {
      emit(InitialForgetState());
      ForgetParams params =
          ForgetParams(username: username, phone: phoneNumber);
      var result = await _useCase.forgetPassword(params);

      if (result.isLeft) {
        if (result.left is NotFoundFailure) {
          emit(InvalidForgetUsernameState(
              message: S.current.txt_not_found_this_account));
        } else if (result.left is OverRequestForgetPasswordFailure) {
          // var overReqMessage = result.left as OverRequestForgetPasswordFailure;
          // emit(
          //     InvalidForgetPhoneNumberState(message: "${overReqMessage.data}"));
          showSnackBar(
              content: S.current.txt_please_wait_a_minute_to_send_otp,
              state: SnackBarState.error);
          return;
        } else if (result.left is NotExistPhoneFailure) {
          emit(InvalidForgetPhoneNumberState(
              message: S.current.txt_not_existing_phone));
        } else {
          showSnackBar(
              content: S.current.txt_no_network_connection,
              state: SnackBarState.error);
          return;
        }
      }
      if (result.isRight) {
        emit(ValidatedForgetState());
        navigatorKey.currentState?.pushNamed(RoutePath.receiveOTP,
            arguments: {"username": username, "phone": phoneNumber});
      }
    }
  }
}
