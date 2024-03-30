import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/src/authentication/data/models/change_password_model.dart';
import 'package:sgas/src/authentication/domain/entities/change_pass_entity.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_state.dart';

class ChangeRepasswordCubit extends Cubit<ChangePasswordState> {
  ChangeRepasswordCubit() : super(InitialChangePassWord());

  AuthenticationUseCase useCase = AuthenticationUseCase();

  void changeState(ChangePasswordState state) {
    emit(state);
  }

  Future<ChangePasswordModel> updatePass(
      {required String token,
      required String newPassword,
      required String username}) async {
    ChangePasswordEntity entity = ChangePasswordEntity(
        newPassword: newPassword, token: token, username: username);
    return await useCase.updateMyPassword(entity);
  }
}
