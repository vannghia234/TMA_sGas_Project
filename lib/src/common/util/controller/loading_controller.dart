import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/src/common/util/constant/screen_size_constant.dart';

class LoadingController {
  bool isActive = false;

  void _active() {
    isActive = true;
  }

  void _inActive() {
    isActive = false;
  }

  void close(BuildContext context) {
    if (isActive) {
      _inActive();
      Navigator.pop(context);
    }
  }

  void start(BuildContext context) {
    bool isTablet =
        MediaQuery.of(context).size.width > ScreenSizeConstant.maxTabletWidth;
    if (isActive) close(context);
    _active();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Center(
            child: isTablet
                ? Lottie.asset(ImagePath.dotLoading,
                    fit: BoxFit.cover, width: 134, height: 150)
                : Lottie.asset(ImagePath.dotLoading,
                    fit: BoxFit.cover, width: 84, height: 94)),
      ),
    );
  }
}
