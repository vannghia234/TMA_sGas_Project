abstract class ChangePasswordState {
  final String message;

  ChangePasswordState({this.message = ""});
}

class InitialChangePassWord extends ChangePasswordState {
  InitialChangePassWord({super.message});
}

class InValidPassword extends ChangePasswordState {
  InValidPassword({super.message});
}
class SuccessValidPassword extends ChangePasswordState {
  SuccessValidPassword({super.message});
}
