import 'package:flutter/material.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.text,
    this.fixedSize = const Size(double.infinity, 48),
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.border,
  });

  final String text;
  final Color? textColor;
  final Color? iconColor;
  final BorderSide? border;
  final Size? fixedSize;
  final MaterialStatePropertyAll<Color>? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      text: text,
      iconWidget: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation(iconColor ?? Colors.white),
        ),
      ),
      textColor: textColor,
      backgroundColor: backgroundColor,
      border: border,
      fixedSize: fixedSize,
    );
  }
}
