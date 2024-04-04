bool atLeast1NumberExist(String num) {
  RegExp regexNumber = RegExp(r'\d');

  return regexNumber.hasMatch(num);
}

bool atLeast1LetterExist(String num) {
  RegExp regexLetter = RegExp(r'[a-zA-Z]');

  return regexLetter.hasMatch(num);
}

bool checkUserNameOnlyContainCharacter(String username) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
  return regex.hasMatch(username);
}

bool isValidUserNameLength(String username) {
  return RegExp(r'^[a-zA-Z0-9]{6,50}$').hasMatch(username);
}

bool isValidPasswordLength(String password) {
  return RegExp(r'^.{8,50}$').hasMatch(password);
}
