import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sgas/core/ui/style/base_color.dart';

class BaseTextStyle {
  static String baseFont = "Inter";

  static TextStyle label1({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle label2({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle label3({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle label4({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle body1({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 18,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle body2({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 16,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle body3({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 14,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle button1({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle button2({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle button3({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle caption1({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 12,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle caption2({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 10,
        color: color ?? BaseColor.textPrimaryColor);
  }
}
