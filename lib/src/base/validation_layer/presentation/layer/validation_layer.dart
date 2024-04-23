import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_cubit.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_state.dart';
import 'package:sgas/src/common/presentation/page/app_loading_page.dart';
import 'package:sgas/src/base/validation_layer/presentation/page/disconnect_page.dart';
import 'package:sgas/src/base/validation_layer/presentation/page/data_parsing_page.dart';
import 'package:sgas/src/base/validation_layer/presentation/page/unsupported_version_page.dart';
import 'package:sgas/src/feature/authentication/presentation/layer/authentication_layer.dart';

class ValidationLayer extends StatelessWidget {
  const ValidationLayer({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ValidationCubit, ValidationState>(
      bloc: getIt.get<ValidationCubit>()..init(),
      builder: (context, state) {
        if (state is ValidatedValidationState) {
          return const AuthenticationLayer();
        }
        if (state is DisconnectedValidationState) {
          return const DisconnectPage();
        }
        if (state is UnsupportedVersionValidationState) {
          return UnSupportVersionPage(
            appVersion: (state).appVersion,
          );
        }
        if (state is ErrorDataParsingValidationState) {
          return const DataParsingPage();
        }
        return const AppLoadingPage();
      },
    );
  }
}
