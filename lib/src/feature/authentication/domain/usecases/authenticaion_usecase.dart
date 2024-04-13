import 'package:either_dart/either.dart';
import 'package:sgas/core/error/exception.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/src/feature/authentication/data/datasources/authentication_datasource.dart';
import 'package:sgas/src/feature/authentication/data/datasources/local_authentication_datasource.dart';
import 'package:sgas/src/feature/authentication/data/models/reset_password_params.dart';
import 'package:sgas/src/feature/authentication/data/models/compare_otp_params.dart';
import 'package:sgas/src/feature/authentication/data/models/forget_params.dart';
import 'package:sgas/src/feature/authentication/data/models/login_params.dart';
import 'package:sgas/src/feature/authentication/data/models/otp_model.dart';
import 'package:sgas/src/feature/authentication/domain/failure/failure.dart';

abstract class AuthenticationUseCaseInterface {
  Future<Either<Failure, void>> login(LoginParams params);
  Future<void> forgetPassword(ForgetParams params);
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
    bool isValidToken = await _localDataSource.checkToken();
    return isValidToken;
  }

  @override
  Future<String?> getAccessToken() async {
    bool isValidToken = await _localDataSource.checkToken();
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
            return Left(CompanyAccountFailure());
          }
        }
      }
      return Left(convertExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(ForgetParams params) async {
    try {
      await _dataSource.forgetPassword(params);
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
