import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/src/authentication/view/bloc/change_new_password_state.dart';

class ChangeNewPasswordCubit extends Cubit<ChangeNewPasswordState> {
  ChangeNewPasswordCubit()
      : super(const ChangeNewPasswordState(
            isEnoughCharacter: false,
            isContainNumber: false,
            isContainLetter: false));

  void changeState(
          {bool? isEnoughCharacter,
          bool? isContainNumber,
          String? err,
          bool? isContainLetter}) =>
      emit(ChangeNewPasswordState(
          error: err ?? "",
          isEnoughCharacter: isEnoughCharacter ?? false,
          isContainLetter: isContainLetter ?? false,
          isContainNumber: isContainNumber ?? false));
}
