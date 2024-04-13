import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/src/common/utils/helper/screen_helper.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget(
      {super.key,
      required this.imgPath,
      required this.title,
      this.titleWidget,
      this.subtitle,
      this.buttonTitle,
      required this.onPress});

  final String imgPath;
  final String title;
  final Widget? titleWidget;
  final String? subtitle;
  final String? buttonTitle;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 250,
          width: getScreenWidth(context),
          child: FractionallySizedBox(
              heightFactor: 1,
              child: Image.asset(
                imgPath,
                fit: BoxFit.contain,
              )),
        ),
        const SizedBox(height: 48),
        titleWidget ??
            Text(title,
                textAlign: TextAlign.center, style: BaseTextStyle.label1()),
        if (subtitle != null)
          Text(subtitle!,
              textAlign: TextAlign.center,
              style: BaseTextStyle.body2(color: BaseColor.textSecondaryColor)),
        if (buttonTitle != null)
          Padding(
            padding: EdgeInsets.only(top: getScreenHeight(context) * 0.02),
            child: CommonButton(
              buttonTitle: buttonTitle!,
              onPress: onPress,
            ),
          ),
      ],
    );
  }
}
