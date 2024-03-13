import 'package:flutter/material.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onpress,
      required this.isDisable});
  final String text;
  final VoidCallback onpress;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: isDisable
            ? CustomColor.buttonDisableColor
            : CustomColor.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onpress,
        child: Text(
          text,
          style: CustomTextStyle.button2(
              textColor:
                  isDisable ? CustomColor.textSecondaryColor : Colors.white),
        ),
      ),
    );
  }
}
