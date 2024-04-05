import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sgas/core/error/exception.dart';

import 'dart:io' as Io;

const _defaultApiWaitingDuration = Duration(seconds: 30);
const _defaultApiGetFileWaitingDuration = Duration(minutes: 5);

Future<void> handleAPIExceptionByStatusCode(
  String uri,
  int statusCode,
  String method,
) async {
  if (statusCode == 200) return;
  debugPrint("[API failure] $statusCode $method $uri");
  // bool isValid = await AuthenticationBrick().authenticate();
  // if (!isValid) {
  //   GetIt.instance.get<AuthenticationCubit>().forceLogout();
  //   return;

  // }
  if (statusCode == 400) throw BadRequestException();
  if (statusCode == 401) throw AuthorizationException();
  if (statusCode == 403) throw ForbiddenException();
  throw ServerException();
}

class ApiServiceClient {
  static Future<Map<String, String>> _headers({
    bool withToken = true,
  }) async {
    // String? token = await AuthenticationBrick().getAccessToken();
    return {
      HttpHeaders.acceptHeader: "application/json",
      // if (withToken == true) HttpHeaders.authorizationHeader: "Bearer $token",
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
}
