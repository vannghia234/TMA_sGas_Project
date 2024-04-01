RegExp regexNumber = RegExp(r'\d');
RegExp regexLetter = RegExp(r'[a-zA-Z]');

bool atLeast1NumberExist(String num) {
  return regexNumber.hasMatch(num);
}

bool atLeast1LetterExist(String num) {
  return regexLetter.hasMatch(num);
}
