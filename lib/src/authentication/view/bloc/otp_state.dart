abstract class OtpState {}

class InitialOtp extends OtpState {}

class IncorrectOtp extends OtpState {}

class TimeOutOtp extends OtpState {}

class WaittingOtp extends OtpState {}

class OverRequestOtp extends OtpState {
  final String mess;
  OverRequestOtp({required this.mess});
}
