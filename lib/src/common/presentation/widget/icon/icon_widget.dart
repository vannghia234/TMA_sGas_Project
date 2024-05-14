import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/ui/style/base_color.dart';

class IconWidget extends StatelessWidget {
  final String path;
  final Color? color;
  final double? size;

  const IconWidget({
    super.key,
    required this.path,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter:
          ColorFilter.mode(color ?? BaseColor.primaryColor, BlendMode.srcIn),
      width: size ?? 28.0,
      height: size ?? 28.0,
    );
  }
}
