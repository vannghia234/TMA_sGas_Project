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

  static TextStyle h1({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 72,
        fontWeight: FontWeight.w700,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle h2({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle h3({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle h4({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle h5({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color ?? BaseColor.textPrimaryColor);
  }

  static TextStyle h6({Color? color}) {
    return TextStyle(
        fontFamily: BaseTextStyle.baseFont,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color ?? BaseColor.textPrimaryColor);
  }
}
