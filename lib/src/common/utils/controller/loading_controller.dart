import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sgas/core/ui/resource/image_path.dart';

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
    if (isActive) close(context);
    _active();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Center(
            child: Lottie.asset(ImagePath.dotLoading,
                fit: BoxFit.cover, width: 84, height: 94)),
      ),
    );
  }
}
