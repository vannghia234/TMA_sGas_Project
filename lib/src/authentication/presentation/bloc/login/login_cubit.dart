import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/utils/helper/logger_helper.dart';
import 'package:sgas/src/authentication/data/models/login_params.dart';
import 'package:sgas/src/authentication/domain/failure/failure.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/presentation/utils/regex_check_valid.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(initial());
  final AuthenticationUseCase _useCase = AuthenticationUseCase();

  Future<void> login(
      {required String username, required String password}) async {
    logger.f("username: $username password $password");
    if (username.isEmpty) {
      emit(InValidUserName(message: "Bạn chưa nhập tài khoản"));
      return;
    } else if (!checkUserNameOnlyContainCharacter(username)) {
      emit(InValidUserName(message: "Tài khoản chỉ chứa kí tự từ a-Z, 0-9"));
      return;
    } else if (!isValidUserNameLength(username)) {
      emit(InValidUserName(message: "Tài khoản phải có từ 6-50 kí tự"));
      return;
    } else if (password.isEmpty) {
      emit(InValidPassWord(message: "Bạn chưa nhập mật khẩu"));
      return;
    } else if (!isValidPasswordLength(password)) {
      emit(InValidPassWord(message: "Mật khẩu phải có từ 8-50 kí tự"));
      return;
    }
    LoginParams loginParams =
        LoginParams(username: username, password: password);
    Either<LoginFailure, void> result = await _useCase.login(loginParams);
    if (result.isLeft) {
      if (result.left is InCorrectUserNamePasswordFailure) {
        emit(InValidPassWord(message: "Sai tài khoản hoặc mật khẩu"));
        return;
      } else if (result.left is AccountHaveBeenBlockedFailure) {
        emit(InValidPassWord(message: "Tài khoản đã bị khóa"));
        return;
      } else if (result.left is AccountHaveBeenBlockedFailure) {
        emit(InValidPassWord(message: "Tài khoản công ty đã bị khóa"));
        return;
      }
    }
    emit(SuccessfulLogin());
  }
}
