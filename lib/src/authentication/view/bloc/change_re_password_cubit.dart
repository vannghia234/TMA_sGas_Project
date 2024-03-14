import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/src/authentication/view/bloc/change_password_state.dart';

class ChangeRepasswordCubit extends Cubit<ChangePasswordState> {
  ChangeRepasswordCubit() : super(InitialChangePassWord());

  void changeState(ChangePasswordState state) {
    emit(state);
  }
}
