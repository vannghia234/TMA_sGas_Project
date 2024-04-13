abstract class ResetPasswordState {
  final String message;
  ResetPasswordState({this.message = ""});
}

class InitialResetPassWord extends ResetPasswordState {
  InitialResetPassWord({super.message});
}

class InValidReEnterPassword extends ResetPasswordState {
  InValidReEnterPassword({super.message});
}

class SuccessValidPassword extends ResetPasswordState {
  SuccessValidPassword({super.message});
}
