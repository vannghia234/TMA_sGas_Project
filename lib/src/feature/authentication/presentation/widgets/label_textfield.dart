import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';

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
          style: BaseTextStyle.label2(color: BaseColor.textPrimaryColor),
          children: <InlineSpan>[
            TextSpan(
              text: '*',
              style: BaseTextStyle.label2(color: BaseColor.alertColor),
            ),
          ],
        ),
      ),
    );
  }
}
