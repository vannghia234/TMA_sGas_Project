abstract class ForgetPasswordState {
  final String message;
  ForgetPasswordState({this.message = ""});
}

class InitialForgetState extends ForgetPasswordState {
  InitialForgetState({super.message});
}

class InvalidForgetUsernameState extends ForgetPasswordState {
  InvalidForgetUsernameState({super.message});
}

class InvalidForgetPhoneNumberState extends ForgetPasswordState {
  InvalidForgetPhoneNumberState({super.message});
}

class ValidatedForgetState extends ForgetPasswordState {}
