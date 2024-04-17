import 'package:sgas/core/error/exception.dart';
import 'package:sgas/src/common/utils/helper/logger_helper.dart';
import 'package:sgas/core/service/client/api_service_client.dart';
import 'package:sgas/core/service/locator/api_service_path.dart';
import 'package:sgas/src/feature/authentication/data/datasources/local_authentication_datasource.dart';
import 'package:sgas/src/feature/authentication/data/models/reset_password_params.dart';
import 'package:sgas/src/feature/authentication/data/models/compare_otp_params.dart';
import 'package:sgas/src/feature/authentication/data/models/forget_params.dart';
import 'package:sgas/src/feature/authentication/data/models/login_params.dart';
import 'package:sgas/src/feature/authentication/data/models/otp_model.dart';
import 'package:sgas/src/feature/authentication/data/models/token_model.dart';

abstract class AuthenticationDataSourceInterface {
  Future<void> login(LoginParams params);
  Future<void> forgetPassword(ForgetParams params);
  Future<OTPModel> compareOTP(CompareOTPParams params);
  Future<void> resetPassword(ResetPasswordParams params);
  Future<void> refresh({required String refreshToken});
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
      logger.d("LOGIN CODE ${res["code"]}");
      TokenModel token = TokenModel.fromJson(res["data"]["token"]);
      LocalAuthenticationDataSource().saveToken(token);
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw DataParsingException();
    }
  }

  @override
  Future<void> forgetPassword(ForgetParams params) async {
    try {
      await ApiServiceClient.post(
          uri: APIServicePath.forgetPassword(),
          withToken: false,
          isAuthentication: true,
          params: params.toMap());
    } catch (e) {
      // 400: incorrect phoneNumber,  404: not found username
      if (e is Exception) {
        logger.f("debug datasource $e");
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
      if (e is Exception) {
        rethrow;
      }
      throw DataParsingException();
    }
  }

  @override
  Future<void> refresh({required String refreshToken}) async {
    try {
      var res = await ApiServiceClient.post(
          withToken: false,
          isAuthentication: true,
          uri: APIServicePath.refreshToken(
              params: {"refreshToken": refreshToken}));
      TokenModel token = TokenModel.fromJson(res["data"]["token"]);
      await LocalAuthenticationDataSource().saveToken(token);
      logger.e("Log refreshTokenCode ${res["code"]}");
    } catch (e) {
      if (e is Exception) {
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
      if (e is Exception) {
        rethrow;
      }
      throw DataParsingException();
    }
  }
}
