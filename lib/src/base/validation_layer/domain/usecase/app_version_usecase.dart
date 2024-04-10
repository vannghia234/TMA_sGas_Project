import 'package:sgas/src/base/validation_layer/data/datasource/app_version_datasource.dart';
import 'package:sgas/src/base/validation_layer/data/model/app_version_model.dart';

abstract class AppVersionUseCaseInterface {
  Future<bool?> isSupportedVersion(AppVersionModel minimumVersion);
  Future<String> getCurrentVersion();
}

class AppVersionUseCase extends AppVersionUseCaseInterface {
  AppVersionDataSource dataSource = AppVersionDataSource();
  @override
  Future<bool?> isSupportedVersion(AppVersionModel minimumVersion) async {
    return await dataSource.isSupportedVersion(minimumVersion);
  }

  @override
  Future<String> getCurrentVersion() async {
    return await dataSource.getCurrentVersion();
  }
}
