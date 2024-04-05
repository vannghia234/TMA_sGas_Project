import 'package:either_dart/either.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/src/authentication/data/datasources/authentication_datasource.dart';
import 'package:sgas/src/authentication/data/datasources/local_authentication_datasource.dart';
import 'package:sgas/src/authentication/data/models/change_password_params.dart';
import 'package:sgas/src/authentication/data/models/compare_otp_params.dart';
import 'package:sgas/src/authentication/data/models/forget_params.dart';
import 'package:sgas/src/authentication/data/models/login_params.dart';
import 'package:sgas/src/authentication/data/models/otp_model.dart';
import 'package:sgas/src/authentication/domain/failure/failure.dart';

abstract class AuthenticationUseCaseInterface {
  Future<Either<LoginFailure, void>> login(LoginParams params);
  Future<void> forgetPassword(ForgetParams params);
  Future<Either<Failure, void>> compareOTP(CompareOTPParams params);
  Future<bool> authenticate();
  Future<String?> getAccessToken();
  Future<void> removeAllToken();
  Future<Either<Failure, void>> changePassword(ChangePasswordParams params);
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
  Future<Either<LoginFailure, void>> login(LoginParams params) async {
    Either<LoginFailure, void> loginResult = await _dataSource.login(params);
    if (loginResult.isLeft) {
      return Left(loginResult.left);
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> forgetPassword(ForgetParams params) async {
    try {
      await _dataSource.forgetPassword(params);
      return const Right(null);
    } catch (e) {
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
      var result = await _dataSource.compareOTP(params);
      return Right(result);
    } catch (e) {
      return Left(convertExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
      ChangePasswordParams params) async {
    try {
      await _dataSource.changePassword(params);
      return const Right(null);
    } catch (e) {
      return Left(convertExceptionToFailure(e));
    }
  }
}
