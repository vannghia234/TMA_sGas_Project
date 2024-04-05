import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/presentation/bloc/authentication/authentication_state.dart';
import 'package:sgas/src/common/utils/contant/global_key.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(InitialAuthenticationState());

  login() {}

  logout() async {
    // TODO: Merge Base feature, change RoutePath.login to .root
    navigatorKey.currentState
        ?.popUntil((route) => route.settings.name == RoutePath.login);
    emit(UnAuthenticateState());
    await AuthenticationUseCase().removeAllToken();
  }

  forceLogout() async {
    await logout();
  }
}
