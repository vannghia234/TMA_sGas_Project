import 'package:flutter/material.dart';
import 'package:sgas/src/base/initial_layer/domain/usecase/language_usecase.dart';
import 'package:sgas/core/ui/resource/image_path.dart';

class LanguageModel {
  LanguageModel({
    required this.code,
    required this.name,
    required this.flag,
    required this.systemLanguageTranslation,
  });

  final String? code;
  final String name;
  final Image flag;
  final String systemLanguageTranslation;
}

class SystemLanguage extends LanguageModel {
  SystemLanguage([String? currentLanguageCode])
      : super(
          code: null,
          name: translateSystemLanguageByCode(currentLanguageCode),
          flag: Image.asset(
            ImagePath.logo,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "",
        );
}

class Vietnamese extends LanguageModel {
  Vietnamese()
      : super(
          code: "vi",
          name: "Tiếng Việt",
          flag: Image.asset(
            ImagePath.logo,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "Ngôn ngữ hệ thống",
        );
}

class English extends LanguageModel {
  English()
      : super(
          code: "en",
          name: "English",
          flag: Image.asset(
            ImagePath.logo,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "System language",
        );
}

String translateSystemLanguageByCode(String? code) {
  if (code == null) return "System language";
  String result = "System language";
  allSupportedLanguages().forEach((element) {
    if (code == element.code) result = element.systemLanguageTranslation;
  });
  return result;
}
