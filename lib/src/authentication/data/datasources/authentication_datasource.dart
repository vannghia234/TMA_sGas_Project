import 'dart:convert';
import 'dart:io';
import 'package:sgas/src/authentication/data/api/api_url.dart';

class AuthenticationDataSource {
  Future<String> login(Map<String, String> body) async {
    HttpClient client = HttpClient();
    String resultString = "";

    // Thực hiện yêu cầu đến máy chủ
    HttpClientRequest request =
        await client.postUrl(Uri.parse(ApiUrl.apiLogin));
    request.headers.add('content-type', 'application/json');
    request.write(jsonEncode(body));
    HttpClientResponse response = await request.close();

    // Đọc dữ liệu từ phản hồi
    resultString = await response.transform(utf8.decoder).join();
    print("DATASOURCE $resultString ${resultString.runtimeType}");

    // Trả về dữ liệu nhận được từ máy chủ
    return resultString;
  }
}
