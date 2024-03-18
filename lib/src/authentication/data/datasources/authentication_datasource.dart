import 'dart:convert';
import 'dart:io';
import 'package:sgas/core/constants/constants.dart';
import 'package:sgas/src/authentication/data/api/api_url.dart';

class AuthenticationDataSource {
  Future<String> login(Map<String, String> body) async {
    try {
      HttpClient client = HttpClient();
      String resultString = "";

      HttpClientRequest request =
          await client.postUrl(Uri.parse(ApiUrl.apiPostLogin));
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
          await client.postUrl(Uri.parse(ApiUrl.apiPostForgetPassword));
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
          await client.postUrl(Uri.parse(ApiUrl.apiPostCompareOtp));
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
        await client.putUrl(Uri.parse(ApiUrl.apiPutUpdatePassword));
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
          .postUrl(Uri.parse(ApiUrl.apiPostRefreshToken + refreshToken));
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
