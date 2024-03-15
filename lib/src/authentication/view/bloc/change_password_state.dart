abstract class ChangePasswordState {
  final String message;

  ChangePasswordState({this.message = ""});
}

class InitialChangePassWord extends ChangePasswordState {
  InitialChangePassWord({super.message});
}

class InValidPassword extends ChangePasswordState {
  bool isEnoughCharacter;
  bool isContainNumber;
  bool isContainLetter;
  InValidPassword(
      {this.isEnoughCharacter = false,
      this.isContainNumber = false,
      this.isContainLetter = false,
      super.message});
}

class InValidRePassword extends ChangePasswordState {
  InValidRePassword({super.message});
}

class SuccessValidPassword extends ChangePasswordState {
  SuccessValidPassword({super.message});
}
