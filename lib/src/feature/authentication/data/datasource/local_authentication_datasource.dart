import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sgas/core/service/client/local_service_client.dart';
import 'package:sgas/core/service/locator/shared_preferences_key.dart';
import 'package:sgas/src/feature/authentication/data/datasource/authentication_datasource.dart';
import 'package:sgas/src/feature/authentication/data/model/token_model.dart';

abstract class LocalAuthenticationDataSourceInterface {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();

  Future<void> saveToken(TokenModel token);
  Future<void> removeAllToken();
  Future<bool> validateToken();
}

class LocalAuthenticationDataSource
    extends LocalAuthenticationDataSourceInterface {
  @override
  Future<String?> getAccessToken() async {
    return await LocalServiceClient.get(SharedPreferencesKey.accessTokenKey);
  }

  @override
  Future<void> removeAllToken() async {
    await LocalServiceClient.remove(SharedPreferencesKey.accessTokenKey);
    await LocalServiceClient.remove(SharedPreferencesKey.refreshTokenKey);
  }

  @override
  Future<void> saveToken(TokenModel token) async {
    await LocalServiceClient.save(
        key: SharedPreferencesKey.accessTokenKey, value: token.accessToken);
    await LocalServiceClient.save(
        key: SharedPreferencesKey.refreshTokenKey, value: token.refreshToken);
  }

  bool isExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  @override
  Future<bool> validateToken() async {
    String? accessToken = await getAccessToken();
    String? refreshToken = await getRefreshToken();
    if (accessToken != null && !isExpired(accessToken)) {
      return true;
    }
    if (refreshToken != null && !isExpired(refreshToken)) {
      await AuthenticationDataSource()
          .refreshAccessToken(refreshToken: refreshToken);
      return await validateToken();
    }
    return false;
  }

  @override
  Future<String?> getRefreshToken() async {
    return await LocalServiceClient.get(SharedPreferencesKey.refreshTokenKey);
  }
}
