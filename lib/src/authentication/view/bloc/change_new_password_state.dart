class ChangeNewPasswordState {
  final bool isEnoughCharacter;
  final bool isContainNumber;
  final bool isContainLetter;
  final String error;

  const ChangeNewPasswordState(
      {required this.isEnoughCharacter,
      required this.isContainNumber,
      this.error = "",
      required this.isContainLetter});
}
