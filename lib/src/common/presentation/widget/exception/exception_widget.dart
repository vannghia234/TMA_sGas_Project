import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/src/common/presentation/widget/button/common_button.dart';
import 'package:sgas/src/common/utils/constant/screen_size_constaint.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= ScreenSizeConstant.minTabletWidth) {
          return SizedBox(
            width: constraints.maxWidth * 2 / 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LogoTMAWidget(imgPath: imgPath, size: const Size(400, 400)),
                const SizedBox(height: 48),
                titleWidget ??
                    Text(title,
                        textAlign: TextAlign.center, style: BaseTextStyle.h5()),
                if (subtitle != null)
                  _SubTitleWidget(
                    subtitle: subtitle,
                    style: BaseTextStyle.body1(),
                  ),
                if (buttonTitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: CommonButton(
                      text: buttonTitle!,
                      onPress: onPress,
                      fixedSize: Size(constraints.maxWidth * 1 / 3, 48),
                    ),
                  ),
              ],
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LogoTMAWidget(
              imgPath: imgPath,
              size: const Size(250, 250),
            ),
            const SizedBox(height: 48),
            titleWidget ??
                Text(title,
                    textAlign: TextAlign.center, style: BaseTextStyle.label1()),
            if (subtitle != null)
              _SubTitleWidget(
                subtitle: subtitle,
                style: BaseTextStyle.body2(),
              ),
            if (buttonTitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: CommonButton(
                  text: buttonTitle!,
                  onPress: onPress,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _LogoTMAWidget extends StatelessWidget {
  const _LogoTMAWidget({
    super.key,
    required this.imgPath,
    required this.size,
  });

  final String imgPath;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imgPath,
      fit: BoxFit.cover,
      height: size.height,
      width: size.width,
    );
  }
}

class _SubTitleWidget extends StatelessWidget {
  const _SubTitleWidget({
    super.key,
    required this.subtitle,
    this.style,
  });

  final String? subtitle;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(subtitle!,
          textAlign: TextAlign.center,
          style: style ??
              BaseTextStyle.body2(color: BaseColor.textSecondaryColor)),
    );
  }
}
