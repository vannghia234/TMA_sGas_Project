import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/ui/resource/icon_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/generated/l10n.dart';

class ValidatePasswordTextField extends StatelessWidget {
  const ValidatePasswordTextField({
    super.key,
    required this.isValidPassword,
  });

  final bool isValidPassword;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          (isValidPassword)
              ? IconPath.fillCheckCircle
              : IconPath.checkCircle,
          height: 24,
          width: 24,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(S.current.txt_password_min_length,
            style: BaseTextStyle.body2(
              color: (isValidPassword)
                  ? BaseColor.textPrimaryColor
                  : BaseColor.textSecondaryColor,
            ))
      ],
    );
  }
}