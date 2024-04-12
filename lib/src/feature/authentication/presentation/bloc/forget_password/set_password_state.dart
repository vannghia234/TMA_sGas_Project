abstract class SetPasswordState {
  final String message;

  SetPasswordState({this.message = ""});
}

class InitialChangePassWord extends SetPasswordState {
  InitialChangePassWord({super.message});
}

class InValidRePassword extends SetPasswordState {
  InValidRePassword({super.message});
}

class SuccessValidPassword extends SetPasswordState {
  SuccessValidPassword({super.message});
}
