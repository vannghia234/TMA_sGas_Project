import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_cubit.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_state.dart';
import 'package:sgas/src/common/presentation/page/app_loading_page.dart';
import 'package:sgas/src/base/validation_layer/presentation/page/disconnect_page.dart';
import 'package:sgas/src/base/validation_layer/presentation/page/data_parsing_page.dart';
import 'package:sgas/src/base/validation_layer/presentation/page/unsupported_version_page.dart';
import 'package:sgas/src/feature/authentication/page/authentication_page.dart';

class ValidationLayer extends StatelessWidget {
  const ValidationLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationCubit, ValidationState>(
      bloc: GetIt.instance.get<ValidationCubit>()..init(),
      builder: (context, state) {
        if (state is ValidatedValidationState) {
          return const AuthenticationPage();
        }
        if (state is DisconnectedValidationState) {
          return const DisconnectPage();
        }
        if (state is UnsupportedVersionValidationState) {
          return UnSupportVersionPage(appVersion: state.appVersion);
        }
        if (state is ErrorDataParsingValidationState) {
          return const DataParsingPage();
        }
        return const AppLoadingPage();
      },
    );
  }
}
