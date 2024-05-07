import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: BaseColor.backgroundNeutralColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Text(
        title,
        style: BaseTextStyle.body2(color: BaseColor.textSecondaryColor),
      ),
    );
  }
}
