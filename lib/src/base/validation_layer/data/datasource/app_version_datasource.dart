import 'package:package_info_plus/package_info_plus.dart';
import 'package:sgas/src/base/validation_layer/data/model/app_version_model.dart';

abstract class AppVersionDataSourceInterface {
  Future<bool?> isSupportedVersion(AppVersionModel minimumVersion);
  Future<String> getCurrentVersion();
  Future<bool?> checkSupportedVersion(AppVersionModel minimumVersion);
}

class AppVersionDataSource extends AppVersionDataSourceInterface {
  @override
  Future<bool?> isSupportedVersion(AppVersionModel minimumVersion) {
    return checkSupportedVersion(minimumVersion);
  }

  @override
  Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<bool?> checkSupportedVersion(AppVersionModel minimumVersion) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppVersionModel? currentVersion =
        AppVersionModel.toModule(packageInfo.version);

    if (currentVersion == null) return null;
    if (currentVersion.major > minimumVersion.major) return true;
    if (currentVersion.major < minimumVersion.major) return false;
    if (currentVersion.minor > minimumVersion.minor) return true;
    if (currentVersion.minor < minimumVersion.minor) return false;
    if (currentVersion.patch < minimumVersion.patch) return false;
    return true;
  }
}
