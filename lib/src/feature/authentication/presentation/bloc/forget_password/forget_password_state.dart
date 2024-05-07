abstract class ForgetPasswordState {}

class ForgetScreenState extends ForgetPasswordState {}

class OtpScreenState extends ForgetPasswordState {
  final String username;
  final String phone;

  OtpScreenState({required this.username, required this.phone});
}

class ResetScreenState extends ForgetPasswordState {}
