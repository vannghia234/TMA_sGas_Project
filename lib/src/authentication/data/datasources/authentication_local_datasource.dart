import 'package:sgas/src/authentication/data/models/authentication_model.dart';

class AuthenticationLocalDataSource {
  List<AuthenticationModel> get listAccount {
    return [
      const AuthenticationModel(email: 'exp@tma.com.vn', password: 'Quanghuy2601'),
      const AuthenticationModel(email: 'test@tma.com.vn', password: 'Huytran2601'),
    ];
  }
}
