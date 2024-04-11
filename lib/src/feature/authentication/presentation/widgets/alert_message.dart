import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({
    super.key,
    this.color,
    this.title,
  });
  final Color? color;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title ?? '',
        style: BaseTextStyle.body2(color: color ?? Colors.red),
      ),
    );
  }
}
