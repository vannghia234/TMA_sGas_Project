import 'package:flutter/material.dart';
import 'package:sgas/core/utils/helper/screen_helper.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.buttonTitle, this.onPress});
  final String buttonTitle;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize:
                MaterialStatePropertyAll(Size(getWidthScreen(context), 48)),
            backgroundColor: MaterialStatePropertyAll((onPress != null)
                ? BaseColor.buttonPrimaryColor
                : BaseColor.backgroundDisableColor)),
        onPressed: onPress ?? () {},
        child: Text(
          buttonTitle,
          style: BaseTextStyle.button1(
              color:
                  (onPress != null) ? Colors.white : BaseColor.greyNeutral400),
        ));
  }
}
