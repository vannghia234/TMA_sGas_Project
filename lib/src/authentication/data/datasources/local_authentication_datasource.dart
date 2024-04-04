import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sgas/core/error/exception.dart';
import 'package:sgas/core/service/client/local_service_client.dart';
import 'package:sgas/core/service/locator/share_reference_key.dart';
import 'package:sgas/src/authentication/data/datasources/authentication_datasource.dart';
import 'package:sgas/src/authentication/data/models/token_model.dart';

abstract class LocalAuthenticationDataSourceInterface {
  Future<dynamic> getAccessToken();
  Future<dynamic> getRefreshToken();

  Future<void> saveToken(TokenModel token);
  Future<void> removeToken();
  bool isExpired(String token);
  Future<bool> checkToken();
}

class LocalAuthenticationDataSource
    extends LocalAuthenticationDataSourceInterface {
  @override
  Future<String?> getAccessToken() async {
    return await LocalServiceClient.get(ShareReferenceKey.accessTokenKey);
  }

  @override
  Future<void> removeToken() async {
    await LocalServiceClient.remove(ShareReferenceKey.accessTokenKey);
    await LocalServiceClient.remove(ShareReferenceKey.refreshTokenKey);  
  }

  @override
  Future<void> saveToken(TokenModel token) async {
    await LocalServiceClient.save(
        key: ShareReferenceKey.accessTokenKey, value: token.accessToken);
    await LocalServiceClient.save(
        key: ShareReferenceKey.refreshTokenKey, value: token.refreshToken);
  }

  @override
  bool isExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  @override
  Future<bool> checkToken() async {
    try {
      String? accessToken = await getAccessToken();
      String? refreshToken = await getRefreshToken();
      if (accessToken != null && !isExpired(accessToken)) {
        return true;
      }
      if (refreshToken != null && !isExpired(refreshToken)) {
        await AuthenticationDataSource().refresh(refreshToken: refreshToken);
      }
      return checkToken();
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw DataParsingException();
    }
  }

  @override
  Future getRefreshToken() async {
    return await LocalServiceClient.get(ShareReferenceKey.refreshTokenKey);
  }
}
