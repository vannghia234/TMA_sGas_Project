import 'package:sgas/src/authentication/data/models/login_model.dart';

abstract class IAuthenticationRepository {
  Future<LoginModel> login({required Map<String, String> body});
  Future<void> forgetPassword();
  Future<void> logout();
  Future<void> getRefreshToken();
  Future<void> compareOtp();
  Future<void> updateMyPassword();
}
