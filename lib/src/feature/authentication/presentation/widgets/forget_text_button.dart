import 'package:flutter/material.dart';
import 'package:sgas/core/config/route/route_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/generated/l10n.dart';

class ForgetTextButton extends StatelessWidget {
  const ForgetTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutePath.forgetPasswordLayer);
          },
          child: Text(
            S.current.lbl_forget_pass,
            style: BaseTextStyle.button1(color: BaseColor.primaryColor),
          ),
        ),
      ),
    );
  }
}
