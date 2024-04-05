import 'package:either_dart/either.dart';
import 'package:sgas/core/error/exception.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/src/base/validation_layer/data/datasource/app_info_datasource.dart';

abstract class AppInfoUseCaseInterface {
  Future<Either<Failure, String>> getSupportedVersion();
}

class AppInfoUseCase extends AppInfoUseCaseInterface {
  final AppInfoDataSource _repository = AppInfoDataSource();

  @override
  Future<Either<Failure, String>> getSupportedVersion() async {
    Either<APIServiceException, String> supportedVersion =
        await _repository.getSupportedVersion();
    Failure? failure;
    if (supportedVersion.isLeft) {
      failure = convertExceptionToFailure(supportedVersion.left);
      return Left(failure);
    }
    return Right(supportedVersion.right);
  }
}
