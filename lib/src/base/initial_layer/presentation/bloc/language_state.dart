abstract class LanguageState {}

class LanguageInitialState extends LanguageState {}

class SetupSuccessLanguageState extends LanguageState {
  final dynamic languageCode;
  final dynamic systemLanguageCode;
  SetupSuccessLanguageState(this.languageCode, this.systemLanguageCode);
}
