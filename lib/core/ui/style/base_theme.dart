import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';

ThemeData baseTheme() {
  final ThemeData base = ThemeData(
    fontFamily: BaseTextStyle.baseFont,
    primaryColor: BaseColor.primaryColor,
    scaffoldBackgroundColor: Colors.white,
  );
  return base;
}
