import 'package:sgas/src/authentication/data/models/change_password_model.dart';
import 'package:sgas/src/authentication/data/models/fotget_moel.dart';
import 'package:sgas/src/authentication/data/models/get_access_token_model.dart';
import 'package:sgas/src/authentication/data/models/login_model.dart';
import 'package:sgas/src/authentication/data/models/otp_model.dart';
import 'package:sgas/src/authentication/data/repositories/authentication_repository.dart';
import 'package:sgas/src/authentication/domain/entities/authentication_entity.dart';
import 'package:sgas/src/authentication/domain/entities/change_pass_entity.dart';
import 'package:sgas/src/authentication/domain/entities/compare_otp_entity.dart';
import 'package:sgas/src/authentication/domain/entities/forget_password_entity.dart';

class AuthenticationUseCase {
  final AuthenticationRepository _repo = AuthenticationRepository();

  Future<LoginModel> loginUseCase(AuthenticationEntity entity) async {
    var res = await _repo.login(
        body: {"username": entity.username, "password": entity.password});
    return res;
  }

  Future<ForgetModel> forgetPassword(ForgetPasswordEntity entity) async {
    var res = await _repo.forgetPassword(
        body: {"username": entity.username, "phone": entity.phone});
    return res;
  }

  Future<OtpModel> compareOtp(CompareOtpEntity entity) async {
    var res = await _repo.compareOtp(
        body: {"username": entity.userName, "oneTimeOtp": entity.otpCode});
    return res;
  }

  Future<ChangePasswordModel> updateMyPassword(
      ChangePasswordEntity entity) async {
    var res = await _repo.updateMyPassword(body: {
      "token": entity.token,
      "username": entity.username,
      "newPassword": entity.newPassword
    });
    return res;
  }

  Future<GetAccessTokenModel> getAccesstokenFromRefreshToken(
      {required String refreshToken}) async {
    var res = await _repo.getRefreshToken(refreshToken: refreshToken);
    return res;
  }
}
