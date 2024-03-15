import 'dart:convert';
import 'package:sgas/src/authentication/data/datasources/authentication_datasource.dart';
import 'package:sgas/src/authentication/data/models/change_password_model.dart';
import 'package:sgas/src/authentication/data/models/fotget_moel.dart';
import 'package:sgas/src/authentication/data/models/login_model.dart';
import 'package:sgas/src/authentication/data/models/otp_model.dart';
import 'package:sgas/src/authentication/domain/repositories/interface_authentication_repository.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  AuthenticationDataSource dataSource = AuthenticationDataSource();

  @override
  Future<OtpModel> compareOtp({required Map<String, String> body}) async {
    String result = await dataSource.compareOTP(body);
    OtpModel model = OtpModel.fromJson(jsonDecode(result));
    return model;
  }

  @override
  Future<ForgetModel> forgetPassword(
      {required Map<String, String> body}) async {
    String result = await dataSource.forgetPassword(body);
    ForgetModel model = ForgetModel.fromJson(jsonDecode(result));
    return model;
  }

  @override
  Future<void> getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<LoginModel> login({required Map<String, String> body}) async {
    String result = await dataSource.login(body);
    LoginModel model = LoginModel.fromJson(jsonDecode(result));
    return model;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<ChangePasswordModel> updateMyPassword(
      {required Map<String, String> body}) async {
    String result = await dataSource.changePassword(body);
    ChangePasswordModel model =
        ChangePasswordModel.fromJson(jsonDecode(result));
    return model;
  }
}
