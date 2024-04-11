import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/src/base/initial_layer/presentation/bloc/language_cubit.dart';
import 'package:sgas/src/base/initial_layer/presentation/bloc/language_state.dart';
import 'package:sgas/src/base/initial_layer/presentation/layer/material_app_layer.dart';
import 'package:sgas/src/common/presentation/page/app_loading_page.dart';

class InitialLayer extends StatelessWidget {
  const InitialLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      bloc: getIt.get<LanguageCubit>()..setupLanguage(),
      builder: (context, state) {
        if (state is SetupSuccessLanguageState) {
          Locale? locale;
          if (state.languageCode != null) {
            locale = Locale(state.languageCode);
          } else if (state.systemLanguageCode != null) {
            locale = Locale(state.systemLanguageCode);
          }
          return MaterialAppLayer(
            locale: locale,
          );
        }
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AppLoadingPage(),
        );
      },
    );
  }
}
