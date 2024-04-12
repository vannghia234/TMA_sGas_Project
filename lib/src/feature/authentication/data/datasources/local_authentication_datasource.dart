import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sgas/core/service/client/local_service_client.dart';
import 'package:sgas/core/service/locator/shared_references_key.dart';
import 'package:sgas/src/feature/authentication/data/datasources/authentication_datasource.dart';
import 'package:sgas/src/feature/authentication/data/models/token_model.dart';

abstract class LocalAuthenticationDataSourceInterface {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();

  Future<void> saveToken(TokenModel token);
  Future<void> removeAllToken();
  Future<bool> checkToken();
}

class LocalAuthenticationDataSource
    extends LocalAuthenticationDataSourceInterface {
  @override
  Future<String?> getAccessToken() async {
    return await LocalServiceClient.get(ShareReferenceKey.accessTokenKey);
  }

  @override
  Future<void> removeAllToken() async {
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

  bool isExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  @override
  Future<bool> checkToken() async {
    String? accessToken = await getAccessToken();
    String? refreshToken = await getRefreshToken();
    if (accessToken != null && !isExpired(accessToken)) {
      return true;
    }
    if (refreshToken != null && !isExpired(refreshToken)) {
      await AuthenticationDataSource().refresh(refreshToken: refreshToken);
      return await checkToken();
    }
    return false;
  }

  @override
  Future<String?> getRefreshToken() async {
    return await LocalServiceClient.get(ShareReferenceKey.refreshTokenKey);
  }
}
