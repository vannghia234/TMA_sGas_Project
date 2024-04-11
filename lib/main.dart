import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/http/http_override_config.dart';
import 'package:sgas/core/config/presentation/orientation_config.dart';
import 'package:sgas/src/base/initial_layer/presentation/layer/initial_layer.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_cubit.dart';

void main() {
  configureDependencies();
  setOrientations();
  HttpOverrides.global = CustomHttpOverrides();
  runApp(
    BlocProvider(
      create: (context) => getIt.get<ValidationCubit>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitialLayer();
  }
}
