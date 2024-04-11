import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/src/feature/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_state.dart';
import 'package:sgas/src/common/utils/constant/global_key.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/login/login_cubit.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(InitialAuthenticationState());

  authenticate() async {
    bool isValidToken = await AuthenticationUseCase().authenticate();
    if (isValidToken) {
      emit(AuthenticatedState());
    } else {
      emit(UnAuthenticateState(expiredToken: true));
    }
  }

  login(username, String password) async {
    await getIt.get<LoginCubit>().login(username: username, password: password);
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
    emit(UnAuthenticateState(expiredToken: true));
  }
}
