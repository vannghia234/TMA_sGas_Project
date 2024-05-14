import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sgas/core/error/failure.dart';
import 'package:sgas/src/common/utils/helper/logger_helper.dart';
import 'package:sgas/src/base/validation_layer/data/model/app_version_model.dart';
import 'package:sgas/src/base/validation_layer/domain/usecase/app_info_usecase.dart';
import 'package:sgas/src/base/validation_layer/domain/usecase/app_version_usecase.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_state.dart';

class ValidationCubit extends Cubit<ValidationState> {
  ValidationCubit() : super(ValidationInitialState());

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    logger.d("current package version ${packageInfo.version}");

    Either<Failure, String> supportedVersion =
        await AppInfoUseCase().getSupportedVersion();
    if (supportedVersion.isLeft) {
      if (supportedVersion.left is ServerFailure) {
        emit(DisconnectedValidationState());
      }
      if (supportedVersion.left is DataParsingFailure) {
        emit(ErrorDataParsingValidationState());
      }
      return;
    }
    AppVersionModel? appSupportedVersion =
        AppVersionModel.toModule(supportedVersion.right);

    if (appSupportedVersion == null) {
      emit(ErrorDataParsingValidationState());
      return;
    }
    bool? isSupportedVersion =
        await AppVersionUseCase().isSupportedVersion(appSupportedVersion);

    if (isSupportedVersion == null) {
      emit(ErrorDataParsingValidationState());
      return;
    }
    if (isSupportedVersion == false) {
      emit(UnsupportedVersionValidationState(packageInfo.version));
      return;
    }
    emit(ValidatedValidationState());
  }

  Future<void> retry() async {
    emit(ValidationInitialState());
    await Future.delayed(const Duration(seconds: 1));
    init();
  }
}
