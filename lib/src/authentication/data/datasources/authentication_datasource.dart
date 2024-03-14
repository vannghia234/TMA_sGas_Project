import 'dart:convert';
import 'dart:io';
import 'package:sgas/src/authentication/data/api/api_url.dart';

class AuthenticationDataSource {
  Future<String> login(Map<String, String> body) async {
    HttpClient client = HttpClient();
    String response = "";
    client
        .postUrl(Uri.parse(ApiUrl.apiLogin))
        .then((HttpClientRequest request) {
      request.headers.add('content-type', 'application/json');

      // Ghi dữ liệu yêu cầu vào body của yêu cầu
      request.write(jsonEncode(body));

      // Gửi yêu cầu và đợi phản hồi từ máy chủ
      return request.close();
    }).then((HttpClientResponse response) async {
      // Xử lý phản hồi ở đây
      response = jsonDecode(await response.transform(utf8.decoder).join());
    });
    return response;
  }
}
