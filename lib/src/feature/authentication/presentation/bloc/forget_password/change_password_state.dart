abstract class ChangePasswordState {
  final String message;

  ChangePasswordState({this.message = ""});
}

class InitialChangePassWord extends ChangePasswordState {
  InitialChangePassWord({super.message});
}

class InValidRePassword extends ChangePasswordState {
  InValidRePassword({super.message});
}

class SuccessValidPassword extends ChangePasswordState {
  SuccessValidPassword({super.message});
}
