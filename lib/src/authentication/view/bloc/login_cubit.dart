import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(initial());

  void changeState(LoginState state) {
    emit(state);
  }
  
}
