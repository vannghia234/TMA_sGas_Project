import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/di/dependency_config.dart';
import 'package:sgas/routes/route_path.dart';
import 'package:sgas/routes/routes.dart';
import 'package:sgas/src/authentication/view/bloc/authentication_bloc.dart';
import 'package:sgas/src/authentication/view/bloc/change_new_password_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/change_new_repassword_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider(create: (_) => getIt<AuthenticationBloc>()),
        BlocProvider(
          create: (context) => getIt<ChangeNewPasswordCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChangeNewRePasswordCubit>(),
        )
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'sGAS',
        routes: routes,
        initialRoute: RoutePath.changeNewPassword,
      ),
    );
  }
}
