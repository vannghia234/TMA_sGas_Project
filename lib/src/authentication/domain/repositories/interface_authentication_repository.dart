import 'package:sgas/src/authentication/data/models/change_password_model.dart';
import 'package:sgas/src/authentication/data/models/fotget_moel.dart';
import 'package:sgas/src/authentication/data/models/get_access_token_model.dart';
import 'package:sgas/src/authentication/data/models/login_model.dart';
import 'package:sgas/src/authentication/data/models/otp_model.dart';

abstract class IAuthenticationRepository {
  Future<LoginModel> login({required Map<String, String> body});
  Future<ForgetModel> forgetPassword({required Map<String, String> body});
  Future<void> logout();
  Future<GetAccessTokenModel> getRefreshToken({required String refreshToken});
  Future<OtpModel> compareOtp({required Map<String, String> body});
  Future<ChangePasswordModel> updateMyPassword(
      {required Map<String, String> body});
}
