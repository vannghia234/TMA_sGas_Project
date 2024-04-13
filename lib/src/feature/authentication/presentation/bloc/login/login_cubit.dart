import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/utils/controller/snack_bar_controller.dart';
import 'package:sgas/src/feature/authentication/data/models/login_params.dart';
import 'package:sgas/src/feature/authentication/domain/failure/failure.dart';
import 'package:sgas/src/feature/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/utils/regex_check_valid.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(initial());
  final AuthenticationUseCase _useCase = AuthenticationUseCase();

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty) {
      emit(InValidUserName(message: S.current.txt_please_enter_username));
      return false;
    } else if (!checkUserNameNotContainSpecialCharacter(username)) {
      emit(InValidUserName(
          message: S.current.txt_username_contain_valid_character));
      return false;
    } else if (!isValidUserNameLength(username)) {
      emit(InValidUserName(message: S.current.txt_username_valid_length));
      return false;
    } else if (password.isEmpty) {
      emit(InValidPassWord(message: S.current.txt_please_enter_password));
      return false;
    } else if (!isValidPasswordLength(password)) {
      emit(InValidPassWord(message: S.current.txt_password_valid_length));
      return false;
    }
    emit(initial());
    LoginParams loginParams =
        LoginParams(username: username, password: password);
    Either<Failure, void> result = await _useCase.login(loginParams);

    if (result.isLeft) {
      if (result.left is InCorrectUserNamePasswordFailure) {
        emit(InValidPassWord(
            message: S.current.txt_incorrect_username_or_password));
        return false;
      } else if (result.left is AccountHaveBeenBlockedFailure) {
        emit(InValidPassWord(message: S.current.txt_account_have_been_blocked));
        return false;
      } else if (result.left is AccountHaveBeenBlockedFailure) {
        emit(InValidPassWord(
            message: S.current.txt_company_account_have_been_blocked));
        return false;
      } else if (result.left is ServerFailure) {
        showSnackBar(
            content: S.current.txt_no_network_connection,
            state: SnackBarState.error);
        return false;
      }
    }
    emit(SuccessfulLogin());
    return true;
  }
}
