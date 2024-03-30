String hideSDT(String input) {
  String hidden = '*' * (input.length - 7);
  String tmp = "${input.substring(0, 3)}$hidden${input.substring(8)}";
  return tmp;
}
