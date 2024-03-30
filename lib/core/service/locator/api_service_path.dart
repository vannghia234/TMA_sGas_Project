class APIServicePath {
  static const baseUrl = "https://sgas.innovation.com.vn/api/user/";
  static const apiPostLogin = "${baseUrl}auth/login";
  static const apiPostRefreshToken = "${baseUrl}auth/refresh";
  static const apiPostLogout = "${baseUrl}auth/refresh?refreshToken=";

  //user/users/
  static const apiPostForgetPassword = "${baseUrl}users/forget-password";
  static const apiPostCompareOtp = "${baseUrl}users/compare-otp";
  static const apiPutUpdatePassword = "${baseUrl}users/password";
}
