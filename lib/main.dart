import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/http/http_override_config.dart';
import 'package:sgas/core/config/presentation/orientation_config.dart';
import 'package:sgas/core/di/dependency_config.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/config/routes/routes.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_re_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_pass_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/login_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/otp_cubit.dart';
import 'package:sgas/src/authentication/presentation/utils/key_storage.dart';

void main() {
  HttpOverrides.global = CustomHttpOverrides();

  setOrientations();

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
        BlocProvider(create: (_) => getIt<ChangeRepasswordCubit>()),
        BlocProvider(
          create: (context) => getIt<ChangePasswordCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ForgetPasswordCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<OtpCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<KeyStorage>(),
        )
        // BlocProvider(
        //   create: (context) => getIt<ChangeNewRePasswordCubit>(),
        // )
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'sGAS',
        routes: routes,
        initialRoute: RoutePath.forgotPassword,
      ),
    );
  }
}
