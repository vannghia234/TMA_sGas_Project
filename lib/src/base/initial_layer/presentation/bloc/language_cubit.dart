import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/base/initial_layer/data/model/language_model.dart';
import 'package:sgas/src/base/initial_layer/domain/usecase/language_usecase.dart';
import 'package:sgas/src/base/initial_layer/presentation/bloc/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  String? _languageCode;

  LanguageCubit() : super(LanguageInitialState());

  Future<void> setupLanguage() async {
    String? currentLanguageCode =
        await LanguageUseCase().getCurrentLanguageCode();
    _languageCode = currentLanguageCode;

    String? systemLanguageCode;
    List<Locale> systemLocales = await LanguageUseCase().getSystemLocales();
    for (var locale in systemLocales) {
      if (S.delegate.isSupported(locale)) {
        systemLanguageCode = locale.languageCode;
        break;
      }
    }

    emit(SetupSuccessLanguageState(currentLanguageCode, systemLanguageCode));
  }

  Future changeLanguage({
    String? languageCode,
    String? notifyLanguageCode,
  }) async {
    await LanguageUseCase()
        .setLanguageCode(languageCode)
        .whenComplete(() async {
      await setupLanguage();
      await Future.delayed(const Duration(seconds: 1));
    });
  }

  String? getLanguageCode() => _languageCode;
}

List<LanguageModel> getSupportedLanguages(String? currentLanguageCode) =>
    LanguageUseCase().getSupportedLanguages(currentLanguageCode);
