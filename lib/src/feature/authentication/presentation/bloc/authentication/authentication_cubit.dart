import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/src/feature/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_state.dart';
import 'package:sgas/src/common/utils/constant/global_key.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/login/login_cubit.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(InitialAuthenticationState());
  bool? isShown;

  authenticate() async {
    bool isValidToken = await AuthenticationUseCase().authenticate();
    if (isValidToken) {
      emit(AuthenticatedState());
    } else {
      isShown ??= true;
      emit(UnAuthenticateState(expiredToken: true));
    }
  }

  login(username, String password) async {
    bool isValid = await getIt
        .get<LoginCubit>()
        .login(username: username, password: password);
    if (isValid) {
      authenticate();
    }
  }

  logout() async {
    navigatorKey.currentState
        ?.popUntil((route) => route.settings.name == RoutePath.root);
    emit(InitialAuthenticationState());
    emit(UnAuthenticateState(expiredToken: false));
    await AuthenticationUseCase().removeAllToken();
  }

  forceLogout() async {
    await logout();
    isShown = null;
    emit(UnAuthenticateState(expiredToken: true));
  }
}
