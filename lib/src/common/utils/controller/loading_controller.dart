import 'package:flutter/material.dart';
import 'package:sgas/core/ui/style/base_color.dart';

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
      builder: (context) => const Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(
            color: BaseColor.blue500,
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }
}
