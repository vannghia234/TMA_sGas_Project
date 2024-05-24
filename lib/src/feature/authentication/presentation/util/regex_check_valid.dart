
import 'package:sgas/src/common/util/constant/string_regex.dart';

bool atLeast1NumberExist(String num) {
  RegExp regexNumber = RegExp(checkExistDigit);
  return regexNumber.hasMatch(num);
}

bool atLeast1LetterExist(String num) {
  RegExp regexLetter = RegExp(checkExistLetter);

  return regexLetter.hasMatch(num);
}

bool checkUserNameNotContainSpecialCharacter(String username) {
  RegExp regex = RegExp(notContainSpecialCharacter);
  return regex.hasMatch(username);
}

bool isValidUserNameLength(String username) {
  return RegExp(checkUsernameLength).hasMatch(username);
}

bool isValidPasswordLength(String password) {
  return RegExp(checkPasswordLength).hasMatch(password);
}
