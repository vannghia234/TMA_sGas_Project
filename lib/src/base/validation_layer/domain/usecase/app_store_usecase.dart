import 'package:either_dart/either.dart';
import 'package:sgas/src/base/validation_layer/data/datasource/app_store_datasource.dart';

abstract class AppStoreUseCaseInterface {
  Future<Either<Exception, void>> goToStore();
}

class AppStoreUseCase extends AppStoreUseCaseInterface {
  AppStoreDataSource dataSource = AppStoreDataSource();
  @override
  Future<Either<Exception, void>> goToStore() async {
    return await dataSource.goToStore();
  }
}
