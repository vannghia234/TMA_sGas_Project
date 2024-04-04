import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/http/http_override_config.dart';
import 'package:sgas/core/config/presentation/orientation_config.dart';
import 'package:sgas/core/di/dependency_config.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/config/routes/routes.dart';
import 'package:sgas/src/authentication/data/datasources/authentication_datasource.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_pass_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/login_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/otp_cubit.dart';

void main() {
  setOrientations();

  HttpOverrides.global = CustomHttpOverrides();

  configDependencies();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginCubit>()),
        BlocProvider(
          create: (context) => getIt<ChangePasswordCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ForgetPasswordCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<OtpCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'sGAS',
        onGenerateRoute: appRoute,
        initialRoute: RoutePath.login,
      ),
    );
  }
}
