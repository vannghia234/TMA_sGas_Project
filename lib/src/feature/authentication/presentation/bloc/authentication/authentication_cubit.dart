import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/src/feature/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_state.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/login/login_cubit.dart';
import 'package:sgas/src/common/utils/constant/global_key.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(InitialAuthenticationState());

  authenticate() async {
    bool isValidToken = await AuthenticationUseCase().authenticate();
    if (isValidToken) {
      emit(AuthenticatedState());
    } else {
      emit(UnAuthenticateState());
    }
  }

  login(BuildContext context, username, String password, {State? state}) async {
    var isSuccessResult = await getIt
        .get<LoginCubit>()
        .login(username: username, password: password);
    if (isSuccessResult) {
      authenticate();
    }
  }

  logout() async {
    navigatorKey.currentState
        ?.popUntil((route) => route.settings.name == RoutePath.root);
    emit(UnAuthenticateState());
    await AuthenticationUseCase().removeAllToken();
  }

  forceLogout() async {
    await logout();
  }
}
