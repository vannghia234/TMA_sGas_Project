part of 'login_cubit.dart';

abstract class LoginState {
  final String message;
  LoginState({this.message = ""});
}

class initial extends LoginState {
  initial({super.message});
}

class InValidUserName extends LoginState {
  InValidUserName({super.message});
}

class InValidPassWord extends LoginState {
  InValidPassWord({super.message});
}

class SuccessfulLogin extends LoginState {
  SuccessfulLogin({super.message});
}
