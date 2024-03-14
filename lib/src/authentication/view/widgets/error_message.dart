import 'package:flutter/material.dart';
import 'package:sgas/core/constants/icon_path.dart';
import 'package:sgas/core/utils/custom_color.dart';
import 'package:sgas/core/utils/custom_textstyle.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.mess,
  });
  final String mess;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(IconPath.error),
        const SizedBox(
          width: 5,
        ),
        Text(
          mess,
          style:
              CustomTextStyle.body3(textColor: CustomColor.semanticAlertColor),
        ),
      ],
    );
  }
}
