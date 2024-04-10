// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class OtpState {}

class InitialOtp extends OtpState {}

class TimeOutOtp extends OtpState {}

class WaitingOtp extends OtpState {}

class OverRequestOtp extends OtpState {
  String? mess;
  OverRequestOtp({this.mess});
}

class IncorrectOtp extends OtpState {}

class CorrectOtp extends OtpState {}
