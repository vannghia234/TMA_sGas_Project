abstract class OtpState {}

class InitialOtp extends OtpState {}

class IncorrectOtp extends OtpState {}

class TimeOutOtp extends OtpState {}

class SentOtp extends OtpState {}

class WaittingOtp extends OtpState {}

class SuccessfulOtp extends OtpState {
  SuccessfulOtp();
}
