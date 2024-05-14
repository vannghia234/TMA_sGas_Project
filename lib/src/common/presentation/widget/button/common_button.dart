import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/src/common/presentation/widget/icon/icon_widget.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      this.text,
      this.onPress,
      this.fixedSize = const Size(double.infinity, 48),
      this.backgroundColor,
      this.icon,
      this.textColor,
      this.border,
      this.borderRadius,
      this.isDisable = false,
      this.iconWidget});

  final String? text;
  final IconWidget? icon;
  final Widget? iconWidget;
  final Color? textColor;
  final BorderSide? border;
  final BorderRadius? borderRadius;
  final bool isDisable;
  final VoidCallback? onPress;
  final Size? fixedSize;
  final MaterialStatePropertyAll<Color>? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(Size(40, 40)),
            padding: const MaterialStatePropertyAll(EdgeInsets.zero),
            splashFactory: InkRipple.splashFactory,
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                side: border ?? BorderSide.none)),
            fixedSize: MaterialStatePropertyAll(fixedSize),
            backgroundColor: (isDisable)
                ? const MaterialStatePropertyAll(
                    BaseColor.backgroundDisableColor)
                : backgroundColor ??
                    const MaterialStatePropertyAll(
                        BaseColor.buttonPrimaryColor)),
        onPressed: isDisable ? () {} : onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconWidget != null)
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: iconWidget!,
              )
            else if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: icon!,
              ),
            if (text != null)
              Text(text!,
                  style: BaseTextStyle.button1(
                      color: isDisable
                          ? BaseColor.greyNeutral400
                          : (textColor ?? Colors.white)))
          ],
        ));
  }
}
