import 'package:either_dart/either.dart';
import 'package:sgas/src/authentication/data/datasources/authentication_datasource.dart';
import 'package:sgas/src/authentication/data/models/login_params.dart';
import 'package:sgas/src/authentication/domain/failure/failure.dart';

abstract class AuthenticationUseCaseInterface {
  Future<Either<LoginFailure, void>> login(LoginParams params);
  Future<void> register();
  Future<bool> authenticate();
  Future<String?> getAccessToken();
  void removeToken();
}

class AuthenticationUseCase extends AuthenticationUseCaseInterface {
  final AuthenticationDataSource _dataSource = AuthenticationDataSource();
  @override
  Future<bool> authenticate() {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<String?> getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<Either<LoginFailure, void>> login(LoginParams params) async {
    Either<LoginFailure, void> loginResult = await _dataSource.login(params);
    if (loginResult.isLeft) {
      return Left(loginResult.left);
    }
    return const Right(null);
  }

  @override
  Future<void> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  void removeToken() {
    // TODO: implement removeToken
  }
}
