import 'package:flutter/material.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';
import 'package:sgas/src/common/presentation/widget/icon/icon_widget.dart';

class CommonIconButton extends StatelessWidget {
  final Color? backgroundColor;
  final Size? size;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double? borderRadius;
  final VoidCallback onPressed;
  final IconWidget icon;

  const CommonIconButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.size,
    this.padding,
    this.borderColor,
    this.borderRadius,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      icon: icon,
      onPress: onPressed,
      fixedSize: size,
      backgroundColor:
          MaterialStatePropertyAll(backgroundColor ?? Colors.transparent),
      border: BorderSide(color: borderColor ?? Colors.transparent),
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
    );
  }
}
