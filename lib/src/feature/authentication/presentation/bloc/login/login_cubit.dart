import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_cubit.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_state.dart';
import 'package:sgas/src/feature/authentication/data/models/login_params.dart';
import 'package:sgas/src/feature/authentication/domain/failure/failure.dart';
import 'package:sgas/src/feature/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/utils/regex_check_valid.dart';
import 'package:sgas/src/common/utils/constant/global_key.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(initial());
  final AuthenticationUseCase _useCase = AuthenticationUseCase();

  Future<bool> login(
      {required String username, required String password}) async {
    if (username.isEmpty) {
      emit(InValidUserName(message: "Bạn chưa nhập tài khoản"));
      return false;
    } else if (!checkUserNameOnlyContainCharacter(username)) {
      emit(InValidUserName(message: "Tài khoản chỉ chứa kí tự từ a-Z, 0-9"));
      return false;
    } else if (!isValidUserNameLength(username)) {
      emit(InValidUserName(message: "Tài khoản phải có từ 6-50 kí tự"));
      return false;
    } else if (password.isEmpty) {
      emit(InValidPassWord(message: "Bạn chưa nhập mật khẩu"));
      return false;
    } else if (!isValidPasswordLength(password)) {
      emit(InValidPassWord(message: "Mật khẩu phải có từ 8-50 kí tự"));
      return false;
    }
    LoginParams loginParams =
        LoginParams(username: username, password: password);
    Either<Failure, void> result = await _useCase.login(loginParams);

    if (result.isLeft) {
      if (result.left is InCorrectUserNamePasswordFailure) {
        emit(InValidPassWord(message: "Sai tài khoản hoặc mật khẩu"));
        return false;
      } else if (result.left is AccountHaveBeenBlockedFailure) {
        emit(InValidPassWord(message: "Tài khoản đã bị khóa"));
        return false;
      } else if (result.left is AccountHaveBeenBlockedFailure) {
        emit(InValidPassWord(message: "Tài khoản công ty đã bị khóa"));
        return false;
      }
    }
    if (result.isRight) {
      emit(SuccessfulLogin());
      navigatorKey.currentState?.popAndPushNamed(RoutePath.home);
      return true;
    }

    getIt.get<ValidationCubit>().emit(DisconnectedValidationState());
    return false;
  }
}
