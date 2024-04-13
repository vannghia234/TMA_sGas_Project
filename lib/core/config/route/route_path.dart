class RoutePath {
  static const root = "/";

  static const authentication = '/authentication';
  static const login = '/authentication/login';
  static const home = '/home';
  static const forgetPassword = '/authentication/forget_password';
  static const receiveOTP = '/authentication/receive_otp';
  static const resetPassword = '/authentication/reset_password';

  static const String notFound = "/common/not_found";
  static const String disconnect = "/common/disconnect";
  static const String unSupportVersion = "/common/unSupport_version";
  static const String errorVersion = "/common/error_version";
}
