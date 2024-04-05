import 'package:flutter/material.dart';
import 'package:sgas/src/base/initial_layer/data/datasource/language_datasource.dart';
import 'package:sgas/src/base/initial_layer/data/model/language_model.dart';

abstract class LanguageBrickInterface {
  Future<String?> getCurrentLanguageCode();

  Future<void> setLanguageCode(String? languageCode);

  Future<List<Locale>> getSystemLocales();

  List<LanguageModel> getSupportedLanguages(String? currentLanguageCode);
}

class LanguageUseCase extends LanguageBrickInterface {
  @override
  Future<String?> getCurrentLanguageCode() async {
    return await LanguageDataSource().getLanguageCode();
  }

  @override
  Future<void> setLanguageCode(String? languageCode) async {
    await LanguageDataSource().saveLanguageCode(languageCode);
  }

  @override
  Future<List<Locale>> getSystemLocales() async {
    final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
    return systemLocales;
  }

  @override
  List<LanguageModel> getSupportedLanguages([String? currentLanguageCode]) {
    return allSupportedLanguages(currentLanguageCode);
  }
}

List<LanguageModel> allSupportedLanguages([String? currentLanguageCode]) {
  List<LanguageModel> languageData = [
    Vietnamese(),
    English(),
  ];
  languageData = sortLanguageByName(languageData);
  languageData.insert(0, SystemLanguage(currentLanguageCode));
  return languageData;
}

List<LanguageModel> sortLanguageByName(List<LanguageModel> languages) {
  List<LanguageModel> newList = [];
  newList = languages;
  newList.sort((a, b) {
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  });
  return newList;
}
