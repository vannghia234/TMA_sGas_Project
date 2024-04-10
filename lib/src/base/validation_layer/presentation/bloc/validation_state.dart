abstract class ValidationState {}

class ValidationInitialState extends ValidationState {}

class DisconnectedValidationState extends ValidationState {}

class ErrorDataParsingValidationState extends ValidationState {}

class UnsupportedVersionValidationState extends ValidationState {
  UnsupportedVersionValidationState(this.appVersion);

  final String appVersion;

  List<Object> get props => [appVersion];
}

class ValidatedValidationState extends ValidationState {}
