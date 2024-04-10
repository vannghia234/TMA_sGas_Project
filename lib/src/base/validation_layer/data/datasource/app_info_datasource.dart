import 'package:either_dart/either.dart';
import 'package:sgas/core/error/exception.dart';
import 'package:sgas/core/service/client/api_service_client.dart';
import 'package:sgas/core/service/locator/api_service_path.dart';

abstract class AppInfoDataSourceInterface {
  Future<Either<APIServiceException, String>> getSupportedVersion();
}

class AppInfoDataSource implements AppInfoDataSourceInterface {
  @override
  Future<Either<APIServiceException, String>> getSupportedVersion() async {
    try {
      String? supportedVersion;
      dynamic rawData = await ApiServiceClient.get(
        withToken: false,
        uri: APIServicePath.ipmAppInfo,
      );
      if (rawData['data'] != null) {
        rawData['data'].forEach((value) {
          if (value['key'] == "APP_VERSION") supportedVersion = value['value'];
        });
      }

      return Right(supportedVersion!);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerException());
      }
      return Left(DataParsingException());
    }
  }
}
