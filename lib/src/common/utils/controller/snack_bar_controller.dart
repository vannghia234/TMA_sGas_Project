import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/src/common/utils/constant/global_key.dart';

enum SnackBarState { success, error }

showSnackBar({required String content, SnackBarState? state}) {
  String svgPath = (state != null)
      ? "assets/icons/fill_error.svg"
      : "assets/icons/fill_check_circle.svg";
  Color textColor = (state != null) ? BaseColor.red500 : BaseColor.green700;

  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
    margin: const EdgeInsets.only(top: 8, bottom: 16, right: 20, left: 20),
    backgroundColor: _mapStateToColor(state),
    content: Row(
      children: [
        SvgPicture.asset(
          svgPath,
          colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: Text(content,
              style: BaseTextStyle.body2(
                color: textColor,
              )),
        ),
      ],
    ),
  ));
}

_mapStateToColor(SnackBarState? state) {
  switch (state) {
    case SnackBarState.success:
      return BaseColor.green60;
    case SnackBarState.error:
      return BaseColor.red60;
    default:
      return BaseColor.green60;
  }
}
