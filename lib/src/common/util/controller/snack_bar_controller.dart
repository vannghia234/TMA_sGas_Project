import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_text_style.dart';
import 'package:sgas/src/common/util/constant/global_key.dart';
import 'package:sgas/src/common/util/constant/screen_size_constaint.dart';

enum SnackBarState { success, error }

showSnackBar({required String content, SnackBarState? state}) {
  final screenSize =
      MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width;
  final isTablet = (screenSize > ScreenSizeConstant.minTabletWidth);

  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    width: (isTablet) ? screenSize * 2 / 3 : null,
    padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
    margin: (isTablet)
        ? null
        : const EdgeInsets.only(top: 8, bottom: 48, right: 20, left: 20),
    backgroundColor: _mapStateToBackgroundColor(state),
    content: Row(
      children: [
        SvgPicture.asset(
          _mapStateToStringPath(state),
          colorFilter:
              ColorFilter.mode(_mapStateToIconColor(state), BlendMode.srcIn),
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: Text(content,
              style: BaseTextStyle.body2(
                color: _mapStateToIconColor(state),
              )),
        ),
      ],
    ),
  ));
}

_mapStateToStringPath(SnackBarState? state) {
  switch (state) {
    case SnackBarState.success:
      return "assets/icons/fill_check_circle.svg";
    case SnackBarState.error:
      return "assets/icons/fill_error.svg";
    default:
      return "assets/icons/fill_check_circle.svg";
  }
}

_mapStateToIconColor(SnackBarState? state) {
  switch (state) {
    case SnackBarState.success:
      return BaseColor.green700;
    case SnackBarState.error:
      return BaseColor.red500;
    default:
      return BaseColor.green700;
  }
}

_mapStateToBackgroundColor(SnackBarState? state) {
  switch (state) {
    case SnackBarState.success:
      return BaseColor.green60;
    case SnackBarState.error:
      return BaseColor.red60;
    default:
      return BaseColor.green60;
  }
}
