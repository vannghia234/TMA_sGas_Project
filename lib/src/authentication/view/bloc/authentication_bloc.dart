import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sgas/src/authentication/domain/entities/authentication_entity.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {
      emit(AuthenticationProcess());
    });

    on<Login>((event, emit) {
      if (event.email.isEmpty && event.password.isEmpty) {
        emit(const AuthenticationFailed(message: 'Bạn chưa nhập tên đăng nhập'));
        return;
      }

      List<AuthenticationEntity> accountlist = AuthenticationUseCase().getListAccount();

      final list = accountlist.where((element) => element.email == event.email && element.password == event.password).toList();

      if (list.isNotEmpty) {
        emit(AuthenticationSuccessfull());
      } else {
        emit(const AuthenticationFailed(message: 'failed'));
      }
    });
  }
}
