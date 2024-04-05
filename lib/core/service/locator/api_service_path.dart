import 'package:sgas/core/service/client/model/api_path_model.dart';

class APIServicePath {
  static const baseUrl = "https://sgas.innovation.com.vn";

  // authentication
  static String login() =>
      APIPathModel(serviceHost: baseUrl, endpoint: "/api/user/auth/login")
          .toStringPath();

  static String refreshToken({required Map<String, String> params}) =>
      APIPathModel(
              serviceHost: baseUrl,
              endpoint: "/api/user/auth/refresh",
              params: params)
          .toStringPath();

  static String logout({required Map<String, String> params}) => APIPathModel(
          serviceHost: baseUrl,
          endpoint: "/api/user/auth/logout",
          params: params)
      .toStringPath();

  static String forgetPassword() => APIPathModel(
          serviceHost: baseUrl, endpoint: "/api/user/users/forget-password")
      .toStringPath();
  static String compareOTP() => APIPathModel(
          serviceHost: baseUrl, endpoint: "/api/user/users/compare-otp")
      .toStringPath();
  static String updatePassword() => APIPathModel(
        serviceHost: baseUrl,
        endpoint: "/api/user/users/password",
      ).toStringPath();
}
