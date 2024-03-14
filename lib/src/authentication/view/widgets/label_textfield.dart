import 'package:flutter/material.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(
        TextSpan(
          text: '$title ',
          style:
              CustomTextStyle.lable2(textColor: CustomColor.textPrimaryColor),
          children: <InlineSpan>[
            TextSpan(
              text: '*',
              style: CustomTextStyle.lable2(
                  textColor: CustomColor.semanticAlertColor),
            ),
          ],
        ),
      ),
    );
  }
}
