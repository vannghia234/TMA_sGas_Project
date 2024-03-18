import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static TextStyle headingH4({Color? textColor}) {
    return GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: (textColor != null) ? textColor : Colors.black,
    );
  }

  static TextStyle headingH6({Color? textColor}) {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: (textColor != null) ? textColor : Colors.black,
    );
  }

  static TextStyle lable2({Color? textColor}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: (textColor != null) ? textColor : Colors.black,
    );
  }

  static TextStyle lable3({Color? textColor}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: (textColor != null) ? textColor : Colors.black,
    );
  }

  static TextStyle body1({Color? textColor}) {
    return GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: (textColor != null) ? textColor : Colors.black,
    );
  }

  static TextStyle body2({Color? textColor}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: (textColor != null) ? textColor : Colors.black,
    );
  }

  static TextStyle body3({Color? textColor}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: (textColor != null) ? textColor : Colors.black,
    );
  }

  static TextStyle button1({Color? textColor}) {
    return GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: (textColor != null) ? textColor : Colors.black,
    );
  }

  static TextStyle button2({Color? textColor}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: (textColor != null) ? textColor : Colors.black,
    );
  }
}
