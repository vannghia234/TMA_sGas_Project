import 'package:sgas/core/error/exception.dart';
import 'package:sgas/core/service/client/api_service_client.dart';
import 'package:sgas/core/service/locator/api_service_path.dart';
import 'package:sgas/src/feature/authentication/data/datasource/local_authentication_datasource.dart';
import 'package:sgas/src/feature/authentication/data/model/reset_password_params.dart';
import 'package:sgas/src/feature/authentication/data/model/compare_otp_params.dart';
import 'package:sgas/src/feature/authentication/data/model/forget-password_params.dart';
import 'package:sgas/src/feature/authentication/data/model/login_params.dart';
import 'package:sgas/src/feature/authentication/data/model/otp_model.dart';
import 'package:sgas/src/feature/authentication/data/model/token_model.dart';

abstract class AuthenticationDataSourceInterface {
  Future<void> login(LoginParams params);
  Future<void> confirmForgetPasswordAccountInfo(ForgetPasswordParams params);
  Future<OTPModel> compareOTP(CompareOTPParams params);
  Future<void> resetPassword(ResetPasswordParams params);
  Future<void> refreshAccessToken({required String refreshToken});
}

class AuthenticationDataSource extends AuthenticationDataSourceInterface {
  @override
  Future<void> login(LoginParams params) async {
    try {
      var res = await ApiServiceClient.post(
          withToken: false,
          isAuthentication: true,
          uri: APIServicePath.login(),
          params: params.toJson());
      TokenModel token = TokenModel.fromJson(res["data"]["token"]);
      LocalAuthenticationDataSource().saveToken(token);
    } catch (e) {
      if (e is APIServiceException) {
        rethrow;
      }
      throw DataParsingException();
    }
  }

  @override
  Future<void> confirmForgetPasswordAccountInfo(
      ForgetPasswordParams params) async {
    try {
      await ApiServiceClient.post(
          uri: APIServicePath.forgetPassword(),
          withToken: false,
          isAuthentication: true,
          params: params.toMap());
    } catch (e) {
      // 400: incorrect phoneNumber,  404: not found username
      if (e is APIServiceException) {
        rethrow;
      }
      throw DataParsingException();
    }
  }

  @override
  Future<void> resetPassword(ResetPasswordParams params) async {
    try {
      await ApiServiceClient.put(
          params: params.toMap(),
          isAuthentication: true,
          uri: APIServicePath.updatePassword(),
          withToken: false);
    } catch (e) {
      if (e is APIServiceException) {
        rethrow;
      }
      throw DataParsingException();
    }
  }

  @override
  Future<void> refreshAccessToken({required String refreshToken}) async {
    try {
      var res = await ApiServiceClient.post(
          withToken: false,
          isAuthentication: true,
          uri: APIServicePath.refreshToken(
              params: {"refreshToken": refreshToken}));
      TokenModel token = TokenModel.fromJson(res["data"]["token"]);
      await LocalAuthenticationDataSource().saveToken(token);
    } catch (e) {
      if (e is APIServiceException) {
        rethrow;
      }
      throw DataParsingException();
    }
  }

  @override
  Future<OTPModel> compareOTP(CompareOTPParams params) async {
    try {
      var response = await ApiServiceClient.post(
          uri: APIServicePath.compareOTP(),
          withToken: false,
          isAuthentication: true,
          params: params.toMap());
      return OTPModel.fromMap(response);
    } catch (e) {
      // not found username 404, incorrect OTP 400
      if (e is APIServiceException) {
        rethrow;
      }
      throw DataParsingException();
    }
  }
}
