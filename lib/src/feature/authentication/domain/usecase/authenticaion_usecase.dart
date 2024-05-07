import 'package:either_dart/either.dart';
import 'package:sgas/core/error/exception.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/src/feature/authentication/data/datasource/authentication_datasource.dart';
import 'package:sgas/src/feature/authentication/data/datasource/local_authentication_datasource.dart';
import 'package:sgas/src/feature/authentication/data/model/reset_password_params.dart';
import 'package:sgas/src/feature/authentication/data/model/compare_otp_params.dart';
import 'package:sgas/src/feature/authentication/data/model/forget-password_params.dart';
import 'package:sgas/src/feature/authentication/data/model/login_params.dart';
import 'package:sgas/src/feature/authentication/data/model/otp_model.dart';
import 'package:sgas/src/feature/authentication/domain/failure/failure.dart';

abstract class AuthenticationUseCaseInterface {
  Future<Either<Failure, void>> login(LoginParams params);
  Future<void> confirmForgetPasswordAccountInfo(ForgetPasswordParams params);
  Future<Either<Failure, void>> compareOTP(CompareOTPParams params);
  Future<bool> authenticate();
  Future<String?> getAccessToken();
  Future<void> removeAllToken();
  Future<Either<Failure, void>> resetPassword(ResetPasswordParams params);
}

class AuthenticationUseCase extends AuthenticationUseCaseInterface {
  final _dataSource = AuthenticationDataSource();
  final _localDataSource = LocalAuthenticationDataSource();
  @override
  Future<bool> authenticate() async {
    bool isValidToken = await _localDataSource.validateToken();
    return isValidToken;
  }

  @override
  Future<String?> getAccessToken() async {
    bool isValidToken = await _localDataSource.validateToken();
    if (isValidToken) {
      return _localDataSource.getAccessToken();
    }
    return null;
  }

  @override
  Future<Either<Failure, void>> login(LoginParams params) async {
    try {
      await _dataSource.login(params);
      return const Right(null);
    } catch (e) {
      if (e is BadRequestException) {
        if (e.statusCode != null) {
          if (e.statusCode == 40001) {
            return Left(InCorrectUserNamePasswordFailure());
          } else if (e.statusCode == 40002) {
            return Left(AccountHaveBeenBlockedFailure());
          } else if (e.statusCode == 40003) {
            return Left(CompanyAccountHaveBeenBlockedFailure());
          }
        }
      }
      return Left(convertExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> confirmForgetPasswordAccountInfo(
      ForgetPasswordParams params) async {
    try {
      await _dataSource.confirmForgetPasswordAccountInfo(params);
      return const Right(null);
    } catch (e) {
      if (e is BadRequestException) {
        if (e.statusCode == 400) {
          return Left(OverRequestForgetPasswordFailure());
        } else if (e.statusCode == 40015) {
          return Left(NotExistPhoneFailure());
        }
      }
      return Left(convertExceptionToFailure(e));
    }
  }

  @override
  Future<void> removeAllToken() async {
    await _localDataSource.removeAllToken();
  }

  @override
  Future<Either<Failure, OTPModel>> compareOTP(CompareOTPParams params) async {
    try {
      var value = await _dataSource.compareOTP(params);
      return Right(value);
    } catch (e) {
      if (e is BadRequestException) {
        if (e.statusCode == 40017) {
          return Left(TimeOutOTPFailure());
        } else {
          return Left(IncorrectOTPFailure());
        }
      }
      return Left(convertExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      ResetPasswordParams params) async {
    try {
      await _dataSource.resetPassword(params);
      return const Right(null);
    } catch (e) {
      return Left(convertExceptionToFailure(e));
    }
  }
}
