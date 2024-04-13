import 'package:flutter/material.dart';
import 'package:sgas/src/common/utils/helper/screen_helper.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.buttonTitle,
      this.onPress,
      this.isLoading = false});
  final String buttonTitle;
  final VoidCallback? onPress;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            splashFactory: InkRipple.splashFactory,
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize:
                MaterialStatePropertyAll(Size(getScreenWidth(context), 48)),
            backgroundColor: MaterialStatePropertyAll((onPress != null)
                ? BaseColor.buttonPrimaryColor
                : BaseColor.backgroundDisableColor)),
        onPressed: onPress ?? () {},
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            Text(
              buttonTitle,
              style: BaseTextStyle.button1(
                  color: (onPress != null)
                      ? Colors.white
                      : BaseColor.greyNeutral400),
            ),
          ],
        ));
  }
}
