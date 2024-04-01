abstract class AuthenticationUseCaseInterface {
  getAccessToken(String key);
  Future<void> removeToken(String key);
  void saveToken(String key);
}

class AuthenticationUseCase extends AuthenticationUseCaseInterface {
  @override
  getAccessToken(String key) {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> removeToken(String key) {
    // TODO: implement removeToken
    throw UnimplementedError();
  }

  @override
  void saveToken(String key) {
    // TODO: implement saveToken
  }
}
