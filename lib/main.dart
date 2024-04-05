import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/http/http_override_config.dart';
import 'package:sgas/core/config/presentation/orientation_config.dart';
import 'package:sgas/core/config/presentation/system_ui_overlay_config.dart';
import 'package:sgas/src/base/initial_layer/presentation/layer/initial_layer.dart';

Future<void> main() async {
  setOrientations();
  HttpOverrides.global = CustomHttpOverrides();
  await configureDependencies();
  runApp(buildSystemUiOverlay(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitialLayer();
  }
}
