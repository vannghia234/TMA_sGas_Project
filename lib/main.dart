import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/http/http_override_config.dart';
import 'package:sgas/core/config/presentation/orientation_config.dart';
import 'package:sgas/core/di/dependency_config.dart';
import 'package:sgas/routes/route_path.dart';
import 'package:sgas/routes/routes.dart';
import 'package:sgas/src/authentication/view/bloc/change_password_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/change_re_password_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/forget_pass_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/login_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/otp_cubit.dart';

void main() {
  HttpOverrides.global = CustomHttpOverrides();

  setOrientations();

  configDependencies();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
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
        // BlocProvider(
        //   create: (context) => getIt<ChangeNewRePasswordCubit>(),
        // )
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'sGAS',
        routes: routes,
        initialRoute: RoutePath.settings,
      ),
    );
  }
}
