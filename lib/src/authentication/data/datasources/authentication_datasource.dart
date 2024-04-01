import 'package:sgas/core/error/exception.dart';
import 'package:sgas/core/helper/logger_helper.dart';
import 'package:sgas/core/service/client/api_service_client.dart';
import 'package:sgas/core/service/locator/api_service_path.dart';
import 'package:sgas/src/authentication/data/models/login_params.dart';

abstract class AuthenticationDataSourceInterface {
  void login(LoginParams params);
  void logout();
  void refresh();
}

class AuthenticationDataSource extends AuthenticationDataSourceInterface {
  @override
  Future<void> login(LoginParams params) async {
    try {
      var res = await ApiServiceClient.post(
          uri: APIServicePath.apiPostLogin, params: params.toJson());
      logger.d("LOGIN CODE ${res["code"]}");
    } catch (e) {
      if (e is ServerException) {
        throw ServerException();
      }
      throw DataParsingException();
    }
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  @override
  void refresh() {
    // TODO: implement refresh
  }
}
