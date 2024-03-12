import 'package:sgas/src/authentication/data/datasources/authentication_local_datasource.dart';
import 'package:sgas/src/authentication/domain/entities/authentication_entity.dart';

class AuthenticationUseCase {
  AuthenticationLocalDataSource authenticationLocalDataSource = AuthenticationLocalDataSource();

  List<AuthenticationEntity> getListAccount() {
    List<AuthenticationEntity> list = [];

    for (var element in authenticationLocalDataSource.listAccount) {
      try {
        list.add(AuthenticationEntity(
          email: element.email,
          password: element.password,
        ));
      } catch (e) {
        continue;
      }
    }

    return list;
  }
}
