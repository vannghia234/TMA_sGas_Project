part of 'login_cubit.dart';

abstract class LoginState {
  final String message;
  LoginState({this.message = ""});
}

class InitialLogin extends LoginState {
  InitialLogin({super.message});
}

class InValidUserNameLogin extends LoginState {
  InValidUserNameLogin({super.message});
}

class InValidPassWordLogin extends LoginState {
  InValidPassWordLogin({super.message});
}

class SuccessfulLogin extends LoginState {
  SuccessfulLogin({super.message});
}
