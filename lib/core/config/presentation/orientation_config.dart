import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This function performs the task of screen rotation lock.
/// Allowing only vertical screen usage for the application.
void setOrientations() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
