import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';

ThemeData baseTheme() {
  final ThemeData base = ThemeData(
    appBarTheme: AppBarTheme(
        titleSpacing: 0,
        elevation: 0,
        centerTitle: false,
        titleTextStyle:
            BaseTextStyle.label2(color: BaseColor.textPrimaryColor)),
    fontFamily: BaseTextStyle.baseFont,
    primaryColor: BaseColor.primaryColor,
    scaffoldBackgroundColor: Colors.white,
  );
  return base;
}
