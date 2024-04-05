import 'package:either_dart/either.dart';
import 'package:sgas/core/error/exception.dart';
import 'package:sgas/core/utils/helper/logger_helper.dart';
import 'package:sgas/core/service/client/api_service_client.dart';
import 'package:sgas/core/service/locator/api_service_path.dart';
import 'package:sgas/src/authentication/data/datasources/local_authentication_datasource.dart';
import 'package:sgas/src/authentication/data/models/change_password_params.dart';
import 'package:sgas/src/authentication/data/models/compare_otp_params.dart';
import 'package:sgas/src/authentication/data/models/forget_params.dart';
import 'package:sgas/src/authentication/data/models/login_params.dart';
import 'package:sgas/src/authentication/data/models/otp_model.dart';
import 'package:sgas/src/authentication/data/models/token_model.dart';
import 'package:sgas/src/authentication/domain/failure/failure.dart';

abstract class AuthenticationDataSourceInterface {
  Future<Either<LoginFailure, void>> login(LoginParams params);
  Future<void> forgetPassword(ForgetParams params);
  Future<OTPModel> compareOTP(CompareOTPParams params);
  Future<void> changePassword(ChangePasswordParams params);
  Future<void> refresh({required String refreshToken});
}

class AuthenticationDataSource extends AuthenticationDataSourceInterface {
  @override
  Future<Either<LoginFailure, void>> login(LoginParams params) async {
    try {
      var res = await ApiServiceClient.post(
          withToken: false,
          uri: APIServicePath.login(),
          params: params.toJson());
      logger.d("LOGIN CODE ${res["code"]}");
      TokenModel token = TokenModel.fromJson(res["data"]["token"]);
      LocalAuthenticationDataSource().saveToken(token);
      return const Right(null);
    } catch (e) {
      if (e is BadRequestException) {
        if (e.statusCode != null) {
          if (e.statusCode == "40001") {
            return Left(InCorrectUserNamePasswordFailure());
          } else if (e.statusCode == "40002") {
            return Left(AccountHaveBeenBlockedFailure());
          } else if (e.statusCode == "40003") {
            return Left(CompanyAccountFailure());
          }
        }
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> forgetPassword(ForgetParams params) async {
    try {
      await ApiServiceClient.post(
          uri: APIServicePath.forgetPassword(),
          withToken: false,
          params: params.toMap());
    } catch (e) {
      // 400: incorrect phoneNumber,  404: not found username
      if (e is Exception) {
        rethrow;
      }
      throw DataParsingException();
    }
  }

  @override
  Future<void> changePassword(ChangePasswordParams params) async {
    try {
      await ApiServiceClient.post(
          params: params.toMap(),
          uri: APIServicePath.updatePassword(),
          withToken: false);
    } catch (e) {
      // todo:

    }
  }

  @override
  Future<void> refresh({required String refreshToken}) async {
    try {
      var res = await ApiServiceClient.post(
          withToken: false,
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
