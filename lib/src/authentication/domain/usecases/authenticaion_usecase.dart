import 'package:sgas/src/authentication/data/models/login_model.dart';
import 'package:sgas/src/authentication/data/repositories/authentication_repository.dart';
import 'package:sgas/src/authentication/domain/entities/authentication_entity.dart';

class AuthenticationUseCase {
  final AuthenticationRepository _repo = AuthenticationRepository();

  Future<LoginModel?> loginUseCase(AuthenticationEntity entity) async {
    var res = await _repo.login(
        body: {"username": entity.username, "password": entity.password});
    if (res.code == 200) {
      print("request login");
      return res;
    }
    return null;
  }
}
