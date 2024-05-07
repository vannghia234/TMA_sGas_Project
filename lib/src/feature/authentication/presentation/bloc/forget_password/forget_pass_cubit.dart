// ignore_for_file: use_build_context_synchronously
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/util/controller/snack_bar_controller.dart';
import 'package:sgas/src/common/util/helper/string_regex_helper.dart';
import 'package:sgas/src/feature/authentication/data/model/forget-password_params.dart';
import 'package:sgas/src/feature/authentication/domain/failure/failure.dart';
import 'package:sgas/src/feature/authentication/domain/usecase/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_pass_state.dart';
import 'package:sgas/src/common/util/helper/transform_phone_number.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(InitialForgetState());
  final _useCase = AuthenticationUseCase();

  Future<bool> forgetPassword(String username, String phoneNumber) async {
    if (username.isEmpty) {
      emit(InvalidForgetUsernameState(
          message: S.current.txt_please_enter_username));
      return false;
    } else if (username.length < 6) {
      emit(InvalidForgetUsernameState(
          message: S.current.txt_at_least_6_characters_username));
      return false;
    } else if (phoneNumber.isEmpty) {
      emit(InvalidForgetPhoneNumberState(
          message: S.current.txt_please_enter_phone_number));
      return false;
    } else if (!RegExp(validPhoneNumber).hasMatch(phoneNumber)) {
      emit(InvalidForgetPhoneNumberState(
          message: S.current.txt_at_least_10_character_phone));
      return false;
    } else {
      emit(InitialForgetState());
      ForgetPasswordParams params = ForgetPasswordParams(
          username: username, phone: transformPhoneNumber(phoneNumber));
      var result = await _useCase.forgetPassword(params);
      if (result.isLeft) {
        if (result.left is NotFoundFailure) {
          emit(InvalidForgetUsernameState(
              message: S.current.txt_not_found_this_account));
          return false;
        } else if (result.left is OverRequestForgetPasswordFailure) {
          return true;
        } else if (result.left is NotExistPhoneFailure) {
          emit(InvalidForgetPhoneNumberState(
              message: S.current.txt_not_existing_phone));
          return false;
        } else {
          showSnackBar(
              content: S.current.txt_no_network_connection,
              state: SnackBarState.error);
          return false;
        }
      }
      emit(ValidatedForgetState());
      return true;
    }
  }
}
