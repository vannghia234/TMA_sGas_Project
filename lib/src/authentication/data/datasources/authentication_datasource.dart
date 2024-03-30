import 'dart:convert';
import 'dart:io';
import 'package:sgas/core/helper/logger_helper.dart';
import 'package:sgas/core/service/locator/api_service_path.dart';

class AuthenticationDataSource {
  Future<String> login(Map<String, String> body) async {
    try {
      HttpClient client = HttpClient();
      String resultString = "";

      HttpClientRequest request =
          await client.postUrl(Uri.parse(APIServicePath.apiPostLogin));
      request.headers.add('content-type', 'application/json');
      request.write(jsonEncode(body));
      HttpClientResponse response = await request.close();

      resultString = await response.transform(utf8.decoder).join();
      logger.f("DATASOURCE LOGIN $resultString ${resultString.runtimeType}");

      return resultString;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> forgetPassword(Map<String, String> body) async {
    try {
      HttpClient client = HttpClient();
      String resultString = "";

      HttpClientRequest request =
          await client.postUrl(Uri.parse(APIServicePath.apiPostForgetPassword));
      request.headers.add('content-type', 'application/json');
      request.write(jsonEncode(body));
      HttpClientResponse response = await request.close();

      // Đọc dữ liệu từ phản hồi
      resultString = await response.transform(utf8.decoder).join();
      logger.f("DATASOURCE FORGET $resultString ${resultString.runtimeType}");

      return resultString;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> compareOTP(Map<String, String> body) async {
    try {
      HttpClient client = HttpClient();
      String resultString = "";

      HttpClientRequest request =
          await client.postUrl(Uri.parse(APIServicePath.apiPostCompareOtp));
      request.headers.add('content-type', 'application/json');
      request.write(jsonEncode(body));
      HttpClientResponse response = await request.close();

      // Đọc dữ liệu từ phản hồi
      resultString = await response.transform(utf8.decoder).join();
      logger.f("DATASOURCE OTP $resultString ${resultString.runtimeType}");

      return resultString;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> changePassword(Map<String, String> body) async {
    HttpClient client = HttpClient();
    String resultString = "";

    HttpClientRequest request =
        await client.putUrl(Uri.parse(APIServicePath.apiPutUpdatePassword));
    request.headers.add('content-type', 'application/json');
    request.write(jsonEncode(body));
    HttpClientResponse response = await request.close();

    // Đọc dữ liệu từ phản hồi
    resultString = await response.transform(utf8.decoder).join();
    logger.f(
        "DATASOURCE changePassword $resultString ${resultString.runtimeType}");

    return resultString;
  }

  Future<String> getAccessTokenFromRefreshToken(
      {required String refreshToken}) async {
    try {
      HttpClient client = HttpClient();
      String resultString = "";

      HttpClientRequest request = await client
          .postUrl(Uri.parse(APIServicePath.apiPostRefreshToken + refreshToken));
      request.headers.add('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      // Đọc dữ liệu từ phản hồi
      resultString = await response.transform(utf8.decoder).join();
      logger.f(
          "DATASOURCE getAccessTokenFromRefreshToken $resultString ${resultString.runtimeType}");

      return resultString;
    } catch (e) {
      throw Exception(e);
    }
  }
}
