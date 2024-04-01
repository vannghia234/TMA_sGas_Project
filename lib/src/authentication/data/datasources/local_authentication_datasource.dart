import 'package:sgas/core/service/client/local_service_client.dart';

abstract class LocalAuthenticationDataSourceInterface {
  dynamic get(String key);
  void save(String key, dynamic value);
  Future<void> remove(String key);
}

class LocalAuthenticationDataSource
    extends LocalAuthenticationDataSourceInterface {
  @override
  dynamic get(String key) {
    try {
      if (LocalServiceClient.get(key) != null) {
        return LocalServiceClient.get(key);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> remove(String key) async {
    await LocalServiceClient.remove(key);
  }

  @override
  void save(String key, value) {
    LocalServiceClient.save(key: key, value: value);
  }
}
