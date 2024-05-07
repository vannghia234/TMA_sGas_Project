import 'dart:async';

import 'package:flutter/material.dart';

const _defaultDelayTime = Duration(milliseconds: 200);
const _defaultRepeatTime = Duration(seconds: 3);

class DebounceController {
  bool isActive = false;
  Timer? _timer;

  void _activate() {
    isActive = true;
  }

  void _inactivate() {
    isActive = false;
  }

  start({
    required VoidCallback function,
    bool isContinuously = false,
    Duration? delayTime,
    Duration? repeatTime,
  }) {
    if (isActive) {
      return;
    }
    if (_timer != null) _timer!.cancel();
    _timer = Timer(delayTime ?? _defaultDelayTime, () {
      _activate();
      function();
      Future.delayed(isContinuously
              ? Duration.zero
              : (repeatTime ?? _defaultRepeatTime))
          .whenComplete(() => end());
    });
  }

  end() {
    if (isActive) {
      _inactivate();
    }
    if (_timer != null) _timer!.cancel();
  }
}
