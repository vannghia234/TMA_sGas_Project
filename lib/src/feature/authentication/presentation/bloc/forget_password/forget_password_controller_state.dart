abstract class ForgetControllerState {}

class ForgetScreenState extends ForgetControllerState {}

class OtpScreenState extends ForgetControllerState {
  final String username;
  final String phone;

  OtpScreenState({required this.username, required this.phone});
}

class ResetScreenState extends ForgetControllerState {}
