import 'dart:convert';
import 'package:sgas/src/authentication/data/datasources/authentication_datasource.dart';
import 'package:sgas/src/authentication/data/models/login_model.dart';
import 'package:sgas/src/authentication/domain/repositories/Iauthentication_repository.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  AuthenticationDataSource dataSource = AuthenticationDataSource();

  @override
  Future<void> compareOtp() {
    // TODO: implement compareOtp
    throw UnimplementedError();
  }

  @override
  Future<void> forgetPassword() {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<LoginModel> login({required Map<String, String> body}) async {
    String result = await dataSource.login(body);
    print("REPOITORY $result");
    LoginModel model = LoginModel.fromJson(jsonDecode(result));
    return model;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> updateMyPassword() {
    // TODO: implement updateMyPassword
    throw UnimplementedError();
  }
}
