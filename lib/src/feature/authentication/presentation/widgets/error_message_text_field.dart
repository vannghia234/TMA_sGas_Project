import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';

class ErrorMessageTextField extends StatelessWidget {
  const ErrorMessageTextField({
    super.key,
    required this.mess,
  });
  final String mess;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(IconPath.error),
          const SizedBox(
            width: 5,
          ),
          Text(
            mess,
            style: BaseTextStyle.body3(color: BaseColor.alertColor),
          ),
        ],
      ),
    );
  }
}
