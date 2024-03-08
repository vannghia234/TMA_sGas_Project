import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This widget configures the System UI Overlay Style to the Dark style.
Widget buildSystemUiOverlay(Widget child) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark, child: child);
}
