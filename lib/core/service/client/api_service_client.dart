import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;
import 'package:sgas/core/error/exception.dart';
import 'package:sgas/core/service/util/handle_api_exception_by_status_code.dart';
import 'package:sgas/src/common/util/helper/logger.dart';
import 'package:sgas/src/feature/authentication/domain/usecase/authenticaion_usecase.dart';

const _defaultApiWaitingDuration = Duration(seconds: 30);
const _defaultApiGetFileWaitingDuration = Duration(minutes: 5);

class ApiServiceClient {
  static Future<Map<String, String>> _headers({
    bool withToken = true,
  }) async {
    String? token = await AuthenticationUseCase().getAccessToken();
    return {
      HttpHeaders.acceptHeader: "application/json",
      if (withToken == true) HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
  }

  static Future<Map<String, dynamic>> get({
    required String uri,
    bool withToken = true,
    Duration? apiWaitingDuration,
    bool isSecondTime = false,
  }) async {
    try {
      final client = http.Client();
      Map<String, String> headers = await _headers(withToken: withToken);

      /// Force close after defined waiting time
      Future.delayed(apiWaitingDuration ?? _defaultApiWaitingDuration)
          .whenComplete(() => client.close());
      http.Response response =
          await client.get(Uri.parse(uri), headers: headers);
      // logger.f(
      //     "code response ${json.decode(utf8.decode(response.bodyBytes)).toString()}");
      await handleAPIExceptionByStatusCode(uri, response.statusCode, "GET");
      Map<String, dynamic> result =
          json.decode(utf8.decode(response.bodyBytes));
      return result;
    } on Io.SocketException catch (_) {
      throw ServerException();
    } catch (e) {
      if (isSecondTime) {
        rethrow;
      } else {
        return await get(
            uri: uri,
            withToken: withToken,
            apiWaitingDuration: apiWaitingDuration,
            isSecondTime: true);
      }
    }
  }

  static Future<Map<String, dynamic>> put(
      {required String uri,
      bool withToken = true,
      Map<String, dynamic>? params,
      Duration? apiWaitingDuration,
      bool isAuthentication = false,
      bool isSecondTime = false}) async {
    try {
      final client = http.Client();
      Map<String, String> headers = await _headers(withToken: withToken);
      Future.delayed(apiWaitingDuration ?? _defaultApiGetFileWaitingDuration)
          .whenComplete(() => client.close());
      var response = await client.put(Uri.parse(uri),
          headers: headers, body: (params != null) ? jsonEncode(params) : null);
      logger.f(
          "code response ${json.decode(utf8.decode(response.bodyBytes)).toString()}");
      await handleAPIExceptionByStatusCode(uri, response.statusCode, "PUT",
          isAuthentication: isAuthentication);
      Map<String, dynamic> result =
          json.decode(utf8.decode(response.bodyBytes));
      return result;
    } on Io.SocketException catch (_) {
      throw ServerException();
    } catch (e) {
      if (isSecondTime) {
        rethrow;
      } else {
        return await put(
            uri: uri,
            params: params,
            isSecondTime: true,
            isAuthentication: isAuthentication,
            withToken: withToken,
            apiWaitingDuration: apiWaitingDuration);
      }
    }
  }

  static Future<Map<String, dynamic>> post({
    required String uri,
    bool withToken = true,
    Map<String, dynamic>? params,
    Duration? apiWaitingDuration,
    bool isSecondTime = false,
    bool isAuthentication = false,
  }) async {
    try {
      final client = http.Client();
      Map<String, String> headers = await _headers(withToken: withToken);

      Future.delayed(apiWaitingDuration ?? _defaultApiWaitingDuration)
          .whenComplete(() => client.close());
      http.Response response = await client.post(Uri.parse(uri),
          headers: headers, body: (params != null) ? jsonEncode(params) : null);

      int? codeBadReq;
      String? data;

      if (response.statusCode == 400) {
        codeBadReq = json.decode(utf8.decode(response.bodyBytes))["code"];
        data = json.decode(utf8.decode(response.bodyBytes))["data"].toString();
      }
      // logger.f(
      //     "code response ${json.decode(utf8.decode(response.bodyBytes)).toString()}");

      await handleAPIExceptionByStatusCode(uri, response.statusCode, "POST",
          isAuthentication: isAuthentication,
          codeBadRequest: codeBadReq,
          data: data);
      Map<String, dynamic> result =
          json.decode(utf8.decode(response.bodyBytes));
      return result;
    } on Io.SocketException catch (_) {
      throw ServerException();
    } catch (e) {
      if (isSecondTime) {
        rethrow;
      } else {
        return await post(
            params: params,
            uri: uri,
            isAuthentication: isAuthentication,
            withToken: withToken,
            apiWaitingDuration: apiWaitingDuration,
            isSecondTime: true);
      }
    }
  }
}
