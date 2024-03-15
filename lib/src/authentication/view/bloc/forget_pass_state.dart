abstract class ForgetPasswordState {
  final String message;
  ForgetPasswordState({this.message = ""});
}
class InititalForgetState extends ForgetPasswordState {
  InititalForgetState({super.message});
}
class InvalidForgetUsername extends ForgetPasswordState {
  InvalidForgetUsername({super.message});
}

class InvalidForgetPhoneNumber extends ForgetPasswordState {
  InvalidForgetPhoneNumber({super.message});
}

class ValidForget extends ForgetPasswordState {}
