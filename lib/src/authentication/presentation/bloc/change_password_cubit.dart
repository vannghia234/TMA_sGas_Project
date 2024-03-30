import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(InitialChangePassWord());

  void changeState(ChangePasswordState state) {
    emit(state);
  }
}
